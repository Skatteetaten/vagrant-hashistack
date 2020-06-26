# vagrant-hashistack

![CI/CD](https://github.com/fredrikhgrelland/vagrant-hashistack/workflows/CI/CD/badge.svg)
![version](https://img.shields.io/badge/dynamic/json?label=latest%20version&query=%24.current_version.version&url=https%3A%2F%2Fapp.vagrantup.com%2Fapi%2Fv1%2Fbox%2Ffredrikhgrelland%2Fhashistack)
![updated](https://img.shields.io/badge/dynamic/json?label=updated&query=%24.current_version.updated_at&url=https%3A%2F%2Fapp.vagrantup.com%2Fapi%2Fv1%2Fbox%2Ffredrikhgrelland%2Fhashistack)

This vagrant box aims to make it dead simple to start a hashistack in a "production state."

---
> 🚧 - current vagrant box runs consul, nomad and vault in `dev` (development) mode.
- [consul development mode](https://learn.hashicorp.com/consul/getting-started/agent)
- [nomad development mode](https://learn.hashicorp.com/nomad/getting-started/running)
- [vault development mode](https://www.vaultproject.io/docs/concepts/dev-server)
---


### Usage

>**_If you are interested in_ using _this box,_ not _developing the box itself, go to [dev-template](https://github.com/fredrikhgrelland/vagrant-hashistack-template-dev)._**

#### Prereqs
`make install` (ubuntu) or `make install-mac` *(mac) will download and install all prerequisites (virtualbox, vagrant) You may want to reboot now!

#### Build and test
`make build` will build a vagrant box based on hashicorp/bionic64

`make test` (dependent on a prior `make build`) will add the built box as local/hashistack, run it and it will start the [countdash](https://www.nomadproject.io/docs/integrations/consul-connect/) consul-connect example.

\* Mac OS prerequisites installation require [package manager - brew](https://brew.sh/)



## Why does this exist?

We needed a Vagrant box with the complete hashistack to use for demo, development and testing.
In order to build cloud native, security minded and dependable services, there exists a killer combination;
- Containers - (Docker)
- Simple&Powerful Orchestrator - (Nomad)
- Service-mesh mTLS - (Consul connect)
- Secrets management - (Vault)

### Hashistack

- Consul
- Nomad
- Vault
- Terraform
- Docker CE

#### - with a side-play of

- Ansible (installed)
- Packer
- consul-template

## Contribute

[See here](docs/CONTRIBUTING.md)
