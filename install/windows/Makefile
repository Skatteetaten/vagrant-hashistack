include ../.env
BINVER=windows_amd64
INSTALLFORMAT=x86_64.msi
VBOXMANAGE="${PROGRAMFILES}/Oracle/VirtualBox/vboxmanage.exe"
export

.ONESHELL .PHONY: prereq check_upgrade stop_vbox install_virtualbox hashicorp_gpg install_vagrant configure_vagrant install_packer
.DEFAULT_GOAL := check_upgrade
check_upgrade:
ifneq (, $(wildcard  ${VBOXMANAGE}))
	make stop_vbox
	make install
else
	make install
endif

stop_vbox:
	${VBOXMANAGE} list runningvms | sed -r 's/.*\{(.*)\}/\1/' | xargs -L1 -I {} ${VBOXMANAGE} controlvm {} savestate
	sudo systemctl stop vboxdrv

install: install_virtualbox hashicorp_gpg install_vagrant configure_vagrant install_packer versions

versions:
	@echo "Virtualbox:\t`${VBOXMANAGE} --version`"
	@echo "Vagrant:\t`vagrant --version`"
	@echo "Packer:\t\t`packer version`"

stop_hashistack_virtualbox:
	${VBOXMANAGE} controlvm "hashistack" acpipowerbutton | true
	sleep 15 # Wait for daemon to complete

install_virtualbox:
	curl -L -s https://download.virtualbox.org/virtualbox/${VIRTUALBOX_VERSION}/SHA256SUMS -o /tmp/virtualbox_SHA256SUMS
	curl -L -s https://download.virtualbox.org/virtualbox/${VIRTUALBOX_VERSION}/${VIRTUALBOX_FULLNAME_WIN} -o /tmp/${VIRTUALBOX_FULLNAME_WIN}

	(cd /tmp; sha256sum --ignore-missing -c virtualbox_SHA256SUMS)
	/tmp/${VIRTUALBOX_FULLNAME_WIN} --silent --ignore-reboot
	rm /tmp/virtualbox_SHA256SUMS /tmp/${VIRTUALBOX_FULLNAME_WIN}

hashicorp_gpg:
	gpg --import ../../ansible/roles/hashistack/files/hashicorp.asc

install_vagrant:
	curl -L -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_SHA256SUMS -o /tmp/vagrant_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_SHA256SUMS.sig -o /tmp/vagrant_SHA256SUMS.sig
	gpg --verify /tmp/vagrant_SHA256SUMS.sig /tmp/vagrant_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_${INSTALLFORMAT} -o /tmp/vagrant_${VAGRANT_VERSION}_${INSTALLFORMAT}
	(cd /tmp; sha256sum --ignore-missing -c vagrant_SHA256SUMS)
	TMPDIR=$(cygpath -d /tmp)
	msiexec //i "${TMPDIR}\vagrant_${VAGRANT_VERSION}_${INSTALLFORMAT}"  //qn //norestart || true
	#SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt vagrant plugin install vagrant-certificates
	rm /tmp/vagrant_SHA256SUMS /tmp/vagrant_SHA256SUMS.sig /tmp/vagrant_${VAGRANT_VERSION}_${INSTALLFORMAT}

configure_vagrant:
	mkdir -p ${HOME}/.vagrant.d
	cp Vagrantfile ${HOME}/.vagrant.d/Vagrantfile

install_packer:
	curl -L -s https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS -o /tmp/packer_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS.sig -o /tmp/packer_SHA256SUMS.sig
	gpg --verify /tmp/packer_SHA256SUMS.sig /tmp/packer_SHA256SUMS
	curl -L -s https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_${BINVER}.zip -o /tmp/packer_${PACKER_VERSION}_${BINVER}.zip
	(cd /tmp; sha256sum --ignore-missing -c packer_SHA256SUMS)
	(cd /tmp; unzip /tmp/packer_${PACKER_VERSION}_${BINVER}.zip)
	chmod +x /tmp/packer
	mv /tmp/packer /usr/bin/
	rm /tmp/packer_SHA256SUMS /tmp/packer_SHA256SUMS.sig /tmp/packer_${PACKER_VERSION}_${BINVER}.zip
