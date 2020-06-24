# Changelog

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
- [startup.yml](ansible/playbooks/start_hashistack.yml) waits until all services are up

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
