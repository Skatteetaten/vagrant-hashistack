include .env
export

.ONESHELL .PHONY: test clean up
.DEFAULT_GOAL := test

up:
	@echo "Running test in template as vagrant's working directory, with its Vagrantfile overriden by: ${VAGRANT_VAGRANTFILE}"
	$(MAKE) -C ../template test

clean:
	vagrant box remove local/hashistack --force || true

test: clean up clean
