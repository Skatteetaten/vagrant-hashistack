include .env
export

.ONESHELL .PHONY: dev clean up rewire
.DEFAULT_GOAL := dev

rewire:
	# TODO: Rewire to bootstrap
	@echo "Adding /vagrant/dev/vagrant/bootstrap/pre_ansible.sh to rewire /etc/ansible to the source of the box, not the packaged one"
	@(mkdir -p ../template/template_example/dev/vagrant/bootstrap; cp -f pre_ansible.sh ../template/template_example/dev/vagrant/bootstrap/)

up: rewire
	@echo "Running example in template as vagrant's working directory, with its Vagrantfile overriden by: ${VAGRANT_VAGRANTFILE}"
	$(MAKE) -C ../template template_example

clean:
	@vagrant box remove local/hashistack --force || true
	@(cd ../template; vagrant destroy -f; rm -f template_example/dev/vagrant/bootstrap/pre_ansible.sh)
	@(rm -fr ansible/facts.d)

dev: clean up
