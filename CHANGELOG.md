# Changelog

## [0.3.2 UNRELEASED]

### Changed

- Changed "Use this template" to button in template/README.md
- Update prereqs to latest versions #247
- Use base box for build #231

### Added

- Changelog enforcer
- Minio section(definition and usage) in template/README.md
- Terraform module documentation in template/README.md
- Template license - Apache 2.0
- Sections to template/README.md
  - "Where to start"
  - "Goals of this template"
  - "Default startup scheme"
  - "Commands"
  - "Terraform Module Requirements"
  - "Accessing Consul, Nomad and Vault"
  - "Test Configuration and Execution"
- `make install` add to template #238

### Fixed

- `make test` fail. Certificates for docker image #239
- Move `make install` to prerequisites #236

## [0.3.1]

### Fixed

- Wrong path in dev/ansible/playbook.yml #213
- Template Vagrantfile wrong paths #218
- Wrong version constraint on 0.3 template #216
- `make test` in template prints errors on pre_ansible.sh and post_ansible.sh #224

## [0.3.0]

### Fixed

- Pre- and post steps runs in lexical order.
- make install: lacking binaries
- make install: missing else statement
- `Make build` will not leave virtualbox vm in halted state.

### Changed

- nomad: acl toggle, refactor bootstrap, tokens via vault
- nomad: 0.11.3 -> 0.12.3
- consul: 1.8.0 -> 1.8.3
- vault: 1.4.2 -> 1.5.0
- consul-template: 0.25.0 -> 0.25.1
- packer: 1.6.0 -> 1.6.1
- terraform: 0.12.26 -> 1.13.0
- nomad ACLs: the toggle is now done on the basis of nomad_acl from  [env.yml](template/test_example/env_default.yml).
- moved installation of unzip from [install.yml](ansible/install.yml) to [bootstrap.sh](packer/bootstrap.sh).
- cleanup and zero out disk before box output in order to reduce time and space consumption.
- box features can now be controlled by environment variables in `.env`
- super-linter version set to latest and only relevant linters is running.

### Added

- Included jq (json query tool) in vagrantbox
- Vault-Consul integration: enable consul secrets engine
- Vault-Consul integration: create dev/admin custom policies, roles and tokens
- Test matrix. relevant box feature permutations will now be tested by default.
- Added healthchecks to the [countdash-job](template/test_example/conf/nomad/countdash.hcl).
- Added [minio](https://min.io) as a running service on port 9000
- Template and test redesign to make Terraform modules center of the template
- Added enterprise binaries: consul, nomad, vault

## [0.2.2]

### Fixed

- Mac installation prerequisites

### Added

- Introduce vagrant-hashistack box life-cycle
- Default extra_vars for ansible provisioner
- Override default extra_vars via ANSIBLE_ARGS or prestart scripts
- Consul ACL default policy based on extra_vars switch

## [0.2.1]

### Changed

- Renamed github actions
- Template push action in separate workflow ( forked & fixed )

### Fixed

- Template was missing directories
- VAGRANT_VAGRANTFILE was not properly referenced

### Added

- README.md in template directories adds a bit of guidance and context

## [0.2.0]

### Changed

- Tests now run based on template ( see Added )
- Updated documentation to be more user focused.
- Vagrant box can now be used without any special config. `vagrant init fredrikhgrelland/hashistack`

### Added

- Publishes a starter repository as [template](template)
- Support for extending and altering configuration of the hashistack
- Support for running pre and post steps on startup
- Starts all services by default on `vagrant up`

## [0.1.2]

### Changed

- Vagrantbox package the necessary network configuration
- Ansible will run playbooks inside of box ( added hosts )

### Added

- pip: docker - `docker_image` available in ansible

### Fixed

- VAULT_ADDR is set to http to match vault configuration
- Better documentation. typos fixed
- Github action release fixed ( retry and log upload )

## [0.1.1]

### Changed

- Github Release with new action

## [0.1.0] - 2020-06-22

### Changed

- First beta version. Should be ready for consumption.
- [startup.yml](ansible/start_hashistack.yml) waits until all services are up

## [0.0.8] - 2020-06-22

### Fixed

- Linting rules
- Release process

## Changed
- Add documentation to released box on vagrant cloud

## [0.0.7] - 2020-06-22

### Added

- Vault as daemon
- Linting in CI/CD

### Fixed

- Startup of services are delayed and controlled by ansible playbook `/etc/ansible/startup.yml` packaged with the box.

### Changed

- consul 1.8.0
- Users of this box must include a startup section in the Vagrant file for hashistack to startup. ~~See Vagrantfile for example.~~

## [0.0.5]

### Added

- Automated tests and release process through github actions

### Changed

- consul 1.8.0-rc1
- packer 1.6.0

## [0.0.4]

### Added

- Tests now started using a combination of terraform and ansible

### Fixed

- Changes to systemd. Ensure startup of network before consul/nomad

## [0.0.2]

### Changed

- Update to Nomad 0.11.3

## [0.0.1]

### Added

- Include changelog

### Fixed

- Add vagrant in docker group #2
