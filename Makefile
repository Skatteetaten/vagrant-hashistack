branch = $(shell git rev-parse --abbrev-ref HEAD)
VAGRANT_VERSION = 2.2.9
PACKER_VERSION = 1.5.6
VIRTUALBOX_VERSION = 6.1.8
VIRTUALBOX_FULLNAME = virtualbox-6.1_6.1.8-137981~Ubuntu~bionic_amd64.deb

.ONESHELL .PHONY: stop_hashistack_virtualbox install_vagrant configure_vagrant install_packer install_virtualbox versions build test
.DEFAULT_GOAL := build

ifeq ($(OS),Windows_NT)
    BINVER=windows_amd64
    INSTALLFORMAT=x86_64.msi
    VIRTUALBOX_FULLNAME=VirtualBox-6.1.8-137981-Win.exe
else
    BINVER=linux_amd64
    INSTALLFORMAT=x86_64.deb
endif

install: install_virtualbox install_gpg install_vagrant configure_vagrant install_packer versions

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

install_virtualbox_win:
	curl -L -s https://download.virtualbox.org/virtualbox/${VIRTUALBOX_VERSION}/SHA256SUMS -o /tmp/virtualbox_SHA256SUMS
	curl -L -s https://download.virtualbox.org/virtualbox/${VIRTUALBOX_VERSION}/${VIRTUALBOX_FULLNAME} -o /tmp/${VIRTUALBOX_FULLNAME}
	(cd /tmp; sha256sum --ignore-missing -c virtualbox_SHA256SUMS)
	/tmp/${VIRTUALBOX_FULLNAME} --silent --ignore-reboot
	rm /tmp/virtualbox_SHA256SUMS /tmp/${VIRTUALBOX_FULLNAME}

install_gpg:
	gpg --import ./ansible/roles/hashistack/files/hashicorp.asc

install_vagrant:
	curl -L -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_SHA256SUMS -o /var/tmp/vagrant_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_SHA256SUMS.sig -o /var/tmp/vagrant_SHA256SUMS.sig
	gpg --verify /var/tmp/vagrant_SHA256SUMS.sig /var/tmp/vagrant_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_${INSTALLFORMAT} -o /var/tmp/vagrant_${VAGRANT_VERSION}_${INSTALLFORMAT}
	(cd /var/tmp; sha256sum --ignore-missing -c vagrant_SHA256SUMS)
	sudo dpkg -i /var/tmp/vagrant_${VAGRANT_VERSION}_${INSTALLFORMAT}
	SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt vagrant plugin install vagrant-certificates
	rm /var/tmp/vagrant_SHA256SUMS /var/tmp/vagrant_SHA256SUMS.sig /var/tmp/vagrant_${VAGRANT_VERSION}_${INSTALLFORMAT}

install_vagrant_win:
	curl -L -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_SHA256SUMS -o /tmp/vagrant_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_SHA256SUMS.sig -o /tmp/vagrant_SHA256SUMS.sig
	gpg --verify /tmp/vagrant_SHA256SUMS.sig /tmp/vagrant_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_${INSTALLFORMAT} -o /tmp/vagrant_${VAGRANT_VERSION}_${INSTALLFORMAT}
	(cd /tmp; sha256sum --ignore-missing -c vagrant_SHA256SUMS)
	TMPDIR=cygpath -d /tmp
	msiexec //i ${TMPDIR}\vagrant_${VAGRANT_VERSION}_${INSTALLFORMAT} //qn
	#SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt vagrant plugin install vagrant-certificates
	#rm /tmp/vagrant_SHA256SUMS /tmp/vagrant_SHA256SUMS.sig /tmp/vagrant_${VAGRANT_VERSION}_${INSTALLFORMAT}

configure_vagrant:
	mkdir -p ~/.vagrant.d
	cp vagrant/GlobalVagrantfile ~/.vagrant.d/Vagrantfile

install_packer:
	curl -L -s https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS -o /tmp/packer_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS.sig -o /tmp/packer_SHA256SUMS.sig
	gpg --verify /tmp/packer_SHA256SUMS.sig /tmp/packer_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_${BINVER}.zip -o /tmp/packer_${PACKER_VERSION}_${BINVER}.zip
	(cd /tmp; sha256sum --ignore-missing -c packer_SHA256SUMS)
	(cd /tmp; unzip /tmp/packer_${PACKER_VERSION}_${BINVER}.zip)
	chmod +x /tmp/packer
	mv /tmp/packer /usr/bin/
	#rm /tmp/packer_SHA256SUMS /tmp/packer_SHA256SUMS.sig /tmp/packer_${PACKER_VERSION}_${BINVER}.zip

build:
	(cd packer; rm -rf output-hashistack; packer build -force .)

build_push:
	#REMEMBER TO SET VAGRANT_CLOUD_TOKEN
	(cd packer; rm -rf output-hashistack; packer build -force cloud-push)

test:
	$(MAKE) -C test test