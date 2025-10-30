#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <module-name> <target-dir>"
    exit 1
fi

MODULE_NAME="$1"
TARGET_DIR="$2"

TARGET_DIR="${TARGET_DIR%/}"
FULL_PATH="$TARGET_DIR/$MODULE_NAME"

echo "Creating project at: $FULL_PATH"
mkdir -p "$FULL_PATH" && echo "Created directory $FULL_PATH"

# Copy .vscode
if [ -d ".vscode" ]; then
    cp -r .vscode "$FULL_PATH/" && echo "Copied .vscode"
else
    echo "Warning: .vscode directory not found, skipping copy."
fi

# Setup bpf/
mkdir -p "$FULL_PATH/bpf" && echo "Created directory bpf/"
if [ -f "vmlinux.h" ]; then
    cp vmlinux.h "$FULL_PATH/bpf/" && echo "Copied vmlinux.h into bpf/"
else
    echo "Warning: vmlinux.h not found, skipping copy."
fi

# Create project directories
mkdir -p "$FULL_PATH/cmd" "$FULL_PATH/internal/timer" "$FULL_PATH/internal/probe"
echo "Created directories: cmd, internal/timer, internal/probe"

# Copy and update main.go
if [ -f "main.go" ]; then
    sed "s|module-name|$MODULE_NAME|g" main.go > "$FULL_PATH/cmd/main.go" \
        && echo "Copied and updated main.go"
else
    echo "Warning: main.go not found, skipping copy."
fi

# Copy other source files
[ -f "timer.go" ] && cp timer.go "$FULL_PATH/internal/timer/" && echo "Copied timer.go" || echo "Warning: timer.go not found"
[ -f "probe.go" ] && cp probe.go "$FULL_PATH/internal/probe/" && echo "Copied probe.go" || echo "Warning: probe.go not found"

# Copy and update Makefile
if [ -f "Makefile" ]; then
    sed "s|module-name|$MODULE_NAME|g" Makefile > "$FULL_PATH/Makefile" \
        && echo "Copied and updated Makefile"
else
    echo "Warning: Makefile not found, skipping copy."
fi

cd "$FULL_PATH" || { echo "Failed to cd into $FULL_PATH"; exit 1; }
echo "Switched to project directory: $FULL_PATH"

echo -e ".vscode\n$MODULE_NAME" > .gitignore
echo "Created .gitignore with entries: .vscode and $MODULE_NAME"

echo "Initializing Go module: $MODULE_NAME"
go mod init "$MODULE_NAME" && echo "Go module initialized"
go mod tidy && echo "Go module tidy completed"

echo "Project setup completed successfully!"