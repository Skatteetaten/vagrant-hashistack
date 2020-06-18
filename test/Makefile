include .env
export

.ONESHELL .PHONY: test clean up
.DEFAULT_GOAL := test

up:
	SSL_CERT_FILE=${SSL_CERT_FILE} CURL_CA_BUNDLE=${CURL_CA_BUNDLE} vagrant up --provision

clean:
	vagrant destroy -f
	vagrant box remove local/hashistack --force || true
	rm -f terraform.tfstate terraform.tfstate.backup

test: clean up clean