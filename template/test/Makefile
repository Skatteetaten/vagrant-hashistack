include .env
export

.ONESHELL .PHONY: test clean up
.DEFAULT_GOAL := test

up:
	vagrant up --provision
	$(MAKE) clean
	# Option 1 how to turn on ACL
	ANSIBLE_ARGS='--extra-vars "consul_agent_acl_default_policy=deny"' vagrant up --provision
	$(MAKE) clean

clean:
	vagrant destroy -f
	rm -rf .vagrant

test: clean up
