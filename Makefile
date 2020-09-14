.ONESHELL .PHONY: install build test
.DEFAULT_GOAL := build

install:
	$(MAKE) -C install

build:
	(cd packer; rm -rf output-hashistack; packer build -force .) || (echo '\n\nIf you get an SSL error you might be behind a transparent proxy. \nMore info https://github.com/fredrikhgrelland/vagrant-hashistack/blob/master/README.md#proxy\n\n' && exit 2)

test:
ifeq (,$(wildcard ./packer/output-hashistack/package.box))
	$(MAKE) build
endif
	$(MAKE) -C test

ssh:
	(cd template; vagrant ssh)

destroy:
	(cd template; vagrant destroy -f)

# submodules
# https://www.vogella.com/tutorials/GitSubmodules/article.html
add-template:
	git submodule add -b master --name template git@github.com:fredrikhgrelland/vagrant-hashistack-template.git template
update-template:
	git submodule update --remote
