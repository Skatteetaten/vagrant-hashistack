include .env
export

.ONESHELL .PHONY: test clean up
.DEFAULT_GOAL := test

up:
	vagrant up --provision

clean:
	vagrant destroy -f
	vagrant box remove local/hashistack --force || true
	rm -f terraform.tfstate terraform.tfstate.backup

test: clean up clean