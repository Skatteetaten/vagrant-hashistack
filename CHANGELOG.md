# Changelog

## [Unreleased]

## [0.0.6] - 2020-06-19

### Added

- Vault as daemon
- Linting in CI/CD

### Fixed

- Startup of services are delayed and controlled by ansible playbook `/etc/ansible/startup.yml` packaged with the box.

### Changed

- consul 1.8.0
- Users of this box must include a startup section in the Vagrant file for hashistack to startup. See [Vagrantfile](Vagrantfile) for example.

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
