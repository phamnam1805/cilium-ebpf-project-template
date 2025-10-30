# cilium-ebpf Project Initializer

This repository contains a small initialization script that bootstraps a new Go project preconfigured for developing with cilium/ebpf.

Why this exists
----------------
Creating a new cilium/ebpf project in Go often requires creating many directories and copying a set of files (Makefile, Go sources, eBPF helpers, headers, etc.). Doing this repeatedly is tedious. I wrote this script to automate the process: it copies the files and folders I always need so I can start coding immediately.

What the script does
--------------------
- Copies a minimal project layout and example files needed for cilium/ebpf development.
- Includes example Go files (e.g. `main.go`, `probe.go`, `timer.go`), a `Makefile`, and `vmlinux.h` or other BPF headers.
- Preserves the minimal structure so you can build, iterate and test eBPF programs quickly.

Quick usage
-----------
1. Make the initializer executable (if needed):

	chmod +x init.sh

2. Run the initializer to create a new project from this template. Example:

	./init.sh my-new-ebpf-project /path/to/your-project/

The script will create a directory named `my-new-ebpf-project` under `/path/to/your-project`

Notes & assumptions
-------------------
- This template reflects my personal minimal setup for cilium/ebpf + Go development. Feel free to adapt the files and layout to your workflow.

License
-------
Use and modify this template however you like.

Enjoy — and happy eBPF hacking!
