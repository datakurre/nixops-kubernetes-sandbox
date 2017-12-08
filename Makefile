SHELL   := /usr/bin/env bash
NIXOPS  := $(shell which nixops)
VERSION := 3eccd0b11d176489d69c778f2fcb544438f3ab56

all: deploy

.created:
	$(NIXOPS) list | grep "Kubernetes Network" || \
	$(NIXOPS) create logical.nix physical.nix -d kubernetes
	touch .created

test: check

check: build

build: .created
	$(NIXOPS) modify logical.nix physical.nix -d kubernetes \
	  -I nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/$(VERSION).tar.gz
	$(NIXOPS) deploy -d kubernetes --build-only

deploy: .created
	$(NIXOPS) deploy -d kubernetes --kill-obsolete --allow-reboot
