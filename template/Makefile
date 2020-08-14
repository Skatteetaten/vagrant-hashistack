include dev/.env
export
export PATH := $(shell pwd)/tmp:$(PATH)

.ONESHELL .PHONY: up update-box destroy-box remove-tmp clean example
.DEFAULT_GOAL := up

#### Development ####
# start commands
dev: update-box
	SSL_CERT_FILE=${SSL_CERT_FILE} CURL_CA_BUNDLE=${CURL_CA_BUNDLE} ANSIBLE_ARGS='--skip-tags "test"' vagrant up --provision

local_test_up: update-box
	SSL_CERT_FILE=${SSL_CERT_FILE} CURL_CA_BUNDLE=${CURL_CA_BUNDLE} ANSIBLE_ARGS='--extra-vars "local_test=true"' vagrant up --provision

remote_test_up: update-box
	SSL_CERT_FILE=${SSL_CERT_FILE} CURL_CA_BUNDLE=${CURL_CA_BUNDLE} vagrant up --provision

remote_test: clean local_test_up

test: clean local_test_up

example:
	cd test_example; SSL_CERT_FILE=${SSL_CERT_FILE} CURL_CA_BUNDLE=${CURL_CA_BUNDLE} vagrant up --provision

# clean commands
destroy-box:
	vagrant destroy -f

remove-tmp:
	rm -rf ./tmp

clean: destroy-box remove-tmp

# helper commands
update-box:
	@SSL_CERT_FILE=${SSL_CERT_FILE} CURL_CA_BUNDLE=${CURL_CA_BUNDLE} vagrant box update || (echo '\n\nIf you get an SSL error you might be behind a transparent proxy. \nMore info https://github.com/fredrikhgrelland/vagrant-hashistack/blob/master/README.md#if-you-are-behind-a-transparent-proxy\n\n' && exit 2)

