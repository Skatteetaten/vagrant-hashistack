include .env
export

.ONESHELL .PHONY: test clean up
.DEFAULT_GOAL := test

up:
	@echo "Running example in template as vagrant's working directory, with its Vagrantfile overriden by: ${VAGRANT_VAGRANTFILE}"
	$(MAKE) -C ../template template_example

clean:
	vagrant box remove local/hashistack --force || true
	@echo "Remove dev rewire: template_example/dev/vagrant/bootstrap/pre_ansible.sh"
	rm -f template_example/dev/vagrant/bootstrap/pre_ansible.sh

test: clean up clean
