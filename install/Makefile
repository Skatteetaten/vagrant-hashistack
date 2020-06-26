.DEFAULT_GOAL := default
UNAME := $(shell uname -s)

default: install versions

install:
ifeq ($(UNAME),Linux)
	$(MAKE) -C linux
endif
ifeq ($(UNAME),Darwin)
	$(MAKE) -C mac
endif

versions:
	@echo "Virtualbox:\t`vboxmanage --version`"
	@echo "Vagrant:\t`vagrant --version`"
	@echo "Packer:\t\t`packer version`"
