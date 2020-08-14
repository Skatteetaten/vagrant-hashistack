include .env
export

.ONESHELL .PHONY: test clean up
.DEFAULT_GOAL := test

up:
	@echo "Running example in template as vagrant's working directory, with its Vagrantfile overriden by: ${VAGRANT_VAGRANTFILE}"
	$(MAKE) -C ../template example

test: up