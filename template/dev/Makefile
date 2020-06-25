include .env
export
export PATH := $(shell pwd)/tmp:$(PATH)

#### Development ####
# start commands
up: clean update-box
	SSL_CERT_FILE=${SSL_CERT_FILE} CURL_CA_BUNDLE=${CURL_CA_BUNDLE} vagrant up --provision

update-box:
	@SSL_CERT_FILE=${SSL_CERT_FILE} CURL_CA_BUNDLE=${CURL_CA_BUNDLE} vagrant box update || (echo '\n\nIf you get an SSL error you might be behind a transparent proxy. \nMore info https://github.com/fredrikhgrelland/vagrant-hashistack/blob/master/README.md#if-you-are-behind-a-transparent-proxy\n\n' && exit 2)

# clean commands
destroy-box:
	vagrant destroy -f

remove-tmp:
	rm -rf ./tmp

clean: destroy-box remove-tmp

copy-consul:
	if [ ! -f "./tmp/consul" ]; then mkdir -p ./tmp; vagrant ssh -c "cp /usr/local/bin/consul /vagrant/tmp/consul"; fi;

#### Test #### TODO: move to test template

test: up
	$(MAKE) -C test test
