include .env
include .env_override
export

.ONESHELL .PHONY: test clean up
.DEFAULT_GOAL := test

up:
	vagrant up --provision
	$(MAKE) clean

clean:
	vagrant destroy -f
	rm -rf .vagrant

test: clean up
