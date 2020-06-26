include .env
export

.ONESHELL .PHONY: test clean up
.DEFAULT_GOAL := test

up:
	@echo Running test in template with overridden Vagrantfile: ${VAGRANT_VAGRANT_FILE}
	$(MAKE) -C ../template test

clean:
	vagrant box remove local/hashistack --force || true

test: clean up clean