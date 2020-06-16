include .env
export

.ONESHELL .PHONY: stop_hashistack_virtualbox install_vagrant configure_vagrant install_packer install_virtualbox versions build test
.DEFAULT_GOAL := build

install: install_virtualbox install_gpg install_vagrant configure_vagrant install_packer versions
install-mac:
	brew cask install virtualbox
	brew cask install vagrant

versions:
	@echo "Virtualbox:\t`vboxmanage --version`"
	@echo "Vagrant:\t`vagrant --version`"
	@echo "Packer:\t\t`packer version`"

stop_hashistack_virtualbox:
	VBoxManage controlvm "hashistack" acpipowerbutton | true
	sleep 15 # Wait for daemon to complete

install_virtualbox:
	curl -L -s https://download.virtualbox.org/virtualbox/${VIRTUALBOX_VERSION}/SHA256SUMS -o /var/tmp/virtualbox_SHA256SUMS
	curl -L -s https://download.virtualbox.org/virtualbox/${VIRTUALBOX_VERSION}/${VIRTUALBOX_FULLNAME} -o /var/tmp/${VIRTUALBOX_FULLNAME}
	(cd /var/tmp; sha256sum --ignore-missing -c virtualbox_SHA256SUMS)
	sudo apt-get install -y gcc make perl
	sudo dpkg -i /var/tmp/${VIRTUALBOX_FULLNAME}
	sudo apt --fix-broken install -y
	rm /var/tmp/virtualbox_SHA256SUMS /var/tmp/${VIRTUALBOX_FULLNAME}

install_gpg:
	gpg --import ./ansible/roles/hashistack/files/hashicorp.asc

install_vagrant:
	curl -L -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_SHA256SUMS -o /var/tmp/vagrant_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_SHA256SUMS.sig -o /var/tmp/vagrant_SHA256SUMS.sig
	gpg --verify /var/tmp/vagrant_SHA256SUMS.sig /var/tmp/vagrant_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_x86_64.deb -o /var/tmp/vagrant_${VAGRANT_VERSION}_x86_64.deb
	(cd /var/tmp; sha256sum --ignore-missing -c vagrant_SHA256SUMS)
	sudo dpkg -i /var/tmp/vagrant_${VAGRANT_VERSION}_x86_64.deb
	SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt vagrant plugin install vagrant-certificates
	rm /var/tmp/vagrant_SHA256SUMS /var/tmp/vagrant_SHA256SUMS.sig /var/tmp/vagrant_${VAGRANT_VERSION}_x86_64.deb

configure_vagrant:
	mkdir -p ~/.vagrant.d
	cp vagrant/GlobalVagrantfile ~/.vagrant.d/Vagrantfile

install_packer:
	curl -L -s https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS -o /var/tmp/packer_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS.sig -o /var/tmp/packer_SHA256SUMS.sig
	gpg --verify /var/tmp/packer_SHA256SUMS.sig /var/tmp/packer_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -o /var/tmp/packer_${PACKER_VERSION}_linux_amd64.zip
	(cd /var/tmp; sha256sum --ignore-missing -c packer_SHA256SUMS)
	(cd /var/tmp; unzip /var/tmp/packer_${PACKER_VERSION}_linux_amd64.zip)
	chmod +x /var/tmp/packer
	sudo mv /var/tmp/packer /usr/local/bin/
	rm /var/tmp/packer_SHA256SUMS /var/tmp/packer_SHA256SUMS.sig /var/tmp/packer_${PACKER_VERSION}_linux_amd64.zip

build:
	(cd packer; rm -rf output-hashistack; packer build -force .)

build_push:
	#REMEMBER TO SET VAGRANT_CLOUD_TOKEN
	(cd packer; rm -rf output-hashistack; packer build -force cloud-push)

test:
	$(MAKE) -C test test
