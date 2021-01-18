include ../.env
export

.ONESHELL .PHONY: install
.DEFAULT_GOAL := install

prereq:
ifeq (, $(shell which brew))
	$(error "No brew in $(PATH), install https://brew.sh to install packages")
else
	@echo "\033[32mBrew exist in path. Proceeding installation! \033[0m"
endif

export-certificates:
# creating a ca-certificates folder and exporting all certificates in MacOS to a ca-certificates.crt file
	mkdir -p /usr/local/share/ca-certificates
	security find-certificate -a -p /Library/Keychains/System.keychain >> /usr/local/share/ca-certificates/ca-certificates.crt
	security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain >> /usr/local/share/ca-certificates/ca-certificates.crt

install: prereq install-software export-certificates vagrant-certificates

install-software:
	brew install --cask virtualbox
	brew install --cask vagrant
# checking if packer is installed before trying to install (fails if you try to install something that's already installed
	brew list packer &>/dev/null || brew install packer

vagrant-certificates:
	SSL_CERT_FILE=/usr/local/share/ca-certificates/ca-certificates.crt vagrant plugin install vagrant-certificates
# vagrantfiles put in .vagrant.d will be appended to ALL vagrantfiles on this system
	mkdir -p ~/.vagrant.d
	cp Vagrantfile ~/.vagrant.d/Vagrantfile
