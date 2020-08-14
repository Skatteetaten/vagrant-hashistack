.ONESHELL .PHONY: install build test
.DEFAULT_GOAL := build

install:
	$(MAKE) -C install

build:
	(cd packer; rm -rf output-hashistack; packer build -force .)

test:
ifeq (,$(wildcard ./packer/output-hashistack/package.box))
	$(MAKE) build
endif
	$(MAKE) -C test

ssh:
	(cd template; vagrant ssh)

destroy:
	(cd template; vagrant destroy -f)