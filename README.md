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

## Build & Test

`make install` (ubuntu) or `make install-mac` *(mac) will download and install all prerequisites (virtualbox, vagrant) You may want to reboot now!

`make build` will build a vagrant box based on hashicorp/bionic64

`make test` (dependent on a prior `make build`) will add the built box as local/hashistack, run it and it will start the [countdash](https://www.nomadproject.io/docs/integrations/consul-connect/) consul-connect example.

\* Mac OS prerequisites installation require [package manager - brew](https://brew.sh/)

## Usage

This is meant to be used as a base-box for different projects to extend on. See [Vagrantfile](./Vagrantfile) for a complete example.

### Requirements

Private network `10.0.3.10` on `eth1`:
```ruby
config.vm.network "private_network", ip: "10.0.3.10"
```

Port forwarding of Hashistack APIs `4646`, `8200` and `8500` to `127.0.0.1`:
```ruby
config.vm.network "forwarded_port", guest: 8500, host: 8500, host_ip: "127.0.0.1"
config.vm.network "forwarded_port", guest: 4646, host: 4646, host_ip: "127.0.0.1"
config.vm.network "forwarded_port", guest: 8200, host: 8200, host_ip: "127.0.0.1"
```

Users of this box must include a startup section
```ruby
config.vm.provision "ansible_local" do |startup|
    run = "always"
    startup.playbook = "/etc/ansible/startup.yml"
end
```

in the Vagrant file for hashistack to startup. See [Vagrantfile](Vagrantfile) for a complete example.
startup.yml will start Vault, Consul and Nomad and then the box will be ready for consul-connect enabled services.
Nomad, Vault and Consul bind on loopback and advertise on the ip `10.0.3.10` which should be available on your local machine.
Portforwarding for nomad on port `4646` should bind to `127.0.0.1` and should allow you to use the nomad binary to post jobs directly.
- Nomad ui is available on [http://10.0.3.10:4646](http://10.0.3.10:4646) and all links to services should work.
- Consul ui is available on [http://10.0.3.10:8500](http://10.0.3.10:8500)
- Vault ui is available on [http://10.0.3.10:8200](http://10.0.3.10:8200)

### Default master tokens

The master token for `Consul` and `Vault` is `master`.

### If you are behind a transparent proxy

If you for any reason find yourself behind a transparent proxy you need to set the environment variables `SSL_CERT_FILE` and `CURL_CA_BUNDLE`. You have three options:
- Prefix `vagrant up`; `SSL_CERT_FILE=<path/to/ca-certificates-file> CURL_CA_BUNDLE=<path/to/ca-certificates-file> vagrant up`
- Set the environment variables in your current session by running `export SSL_CERT_FILE=<path/to/ca-certificates-file>` and `export CURL_CA_BUNDLE=<path/to/ca-certificates-file>` in the terminal. Eg:`export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt`
- Set the environment variables permanently by adding the export commands above to your `~/.bashrc` or equivalent.

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
