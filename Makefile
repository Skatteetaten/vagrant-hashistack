.ONESHELL .PHONY: install build test dev lint
.DEFAULT_GOAL := build

install:
	$(MAKE) -C install

build: remove-tmp remove-built-box
	@(cd packer; packer build -force .) || (echo '\n\nIf you get an SSL error you might be behind a transparent proxy.\nMore info https://github.com/fredrikhgrelland/vagrant-hashistack/blob/master/README.md#proxy\n\n' && exit 2)

lint:
	@(docker run -v $$PWD:/tmp/lint --env RUN_LOCAL=true --env FILTER_REGEX_EXCLUDE="(packer/output-hashistack|.vagrant|template)/*" --env VALIDATE_TERRAGRUNT=false --rm github/super-linter)

test:
ifeq (,$(wildcard ./packer/output-hashistack/package.box))
	$(MAKE) build
endif
	$(MAKE) -C test

dev:
ifeq (,$(wildcard ./packer/output-hashistack/package.box))
	$(MAKE) build
endif
	$(MAKE) -C dev

ssh:
	(cd template; vagrant ssh)

clean: remove-tmp destroy-box

destroy-box:
	(cd template; vagrant destroy -f)

remove-tmp:
	rm -fr ansible/facts.d

remove-built-box:
	cd packer
	rm -rf output-hashistack

# submodules
# https://www.vogella.com/tutorials/GitSubmodules/article.html
## Point to latest commit in remote submodule
update-submodule:
	git submodule update --init
	git submodule update --remote
