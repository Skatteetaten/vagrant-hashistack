include .env
include .env_override
export

.ONESHELL .PHONY: test clean up
.DEFAULT_GOAL := test

up:
	ANSIBLE_ARGS='--extra-vars "consul_agent_acl_default_policy=${consul_agent_acl_default_policy}"' vagrant up --provision
	$(MAKE) clean

clean:
	vagrant destroy -f
	rm -rf .vagrant

test: clean up
