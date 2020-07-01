include ../.env
export

.ONESHELL .PHONY: install
.DEFAULT_GOAL := prereq

prereq:
ifeq (, $(shell which brew))
 $(error "No brew in $(PATH), install https://brew.sh to install packages")
endif

install:
	brew cask install virtualbox
	brew cask install vagrant
	brew install packer