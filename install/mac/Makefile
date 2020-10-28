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

install: prereq
	brew cask install virtualbox
	brew cask install vagrant
	brew install packer
