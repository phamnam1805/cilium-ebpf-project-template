generate: 
	go generate ./...

build-module-name:
	go build -ldflags "-s -w" -o module-name cmd/main.go

build: generate build-module-name

clean:
	rm -f module-name
	rm -f internal/probe/probe_bpf*.go
	rm -f internal/probe/probe_bpf*.o