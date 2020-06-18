![CI/CD](https://github.com/fredrikhgrelland/vagrant-hashistack/workflows/CI/CD/badge.svg)
# vagrant-hashistack
### WARNING: Under heavy development. Do not use.
### TL;DR
This vagrant box aims to make it dead simple to start a hashistack in a "production state."

---
> 🚧:construction: - current vagrant box runs consul, nomad and vault in `dev` (development) mode .
- [consul development mode](https://learn.hashicorp.com/consul/getting-started/agent)
- [nomad development mode](https://learn.hashicorp.com/nomad/getting-started/running)
- [consul development mode](https://www.vaultproject.io/docs/concepts/dev-server)
---
## Build & Test
`make install` (ubuntu) or `make install-mac` *(mac) will download and install all prerequisites (virtualbox, vagrant) You may want to reboot now!

`make build` will build a vagrant box based on hashicorp/bionic64 

`make test` (dependent on a prior `make build`) will add the built box as local/hashistack, run it and start the [countdash](https://www.nomadproject.io/docs/integrations/consul-connect/) consul-connect example.

\* Mac OS prerequisites installation require [package manager - brew](https://brew.sh/)   
## Usage
This is meant to be used as a base-box for different projects to extend on. See [Vagrantfile](./Vagrantfile) for a complete example.

Requirements:
Private network `10.0.3.10` on `eth1`
Port forwarding og `4646`, `8500` and `8200` to `127.0.0.1`

This box will autostart Docker, Consul, Nomad and Vault ready for consul-connect enabled services.
Consul, Nomad and Vault bind on loopback and advertise on the ip `10.0.3.10` which should be available on your local machine.
Port forwarding for nomad on port `4646` should bind to `127.0.0.1` and should allow you to use the nomad binary to post jobs directly.
- Nomad ui is available on [http://10.0.3.10:4646](http://10.0.3.10:4646) and all links to services should work.
- Consul ui is available on [http://10.0.3.10:8500](http://10.0.3.10:8500)
- Vault ui is available on [http://10.0.3.10:8200](http://10.0.3.10:8200)

### Default master tokens for Nomad and Consul
The default master token for both `Nomad` and `Consul` is `b6e29626-e23d-98b4-e19f-c71a96fbdef7`. This is temporary, and only applicable until `Vault` has been integrated. `Vault`'s default master token is `root`.

### If you are behind a transparent proxy
If you for any reason find yourself behind a transparent proxy you need to set the environment variables `SSL_CERT_FILE` and `CURL_CA_BUNDLE`. You have three options:
1. Prefix `vagrant up`; `SSL_CERT_FILE=<path/to/ca-certificates-file> CURL_CA_BUNDLE=<path/to/ca-certificates-file> vagrant up` 
2. Set the environment variables in your current session by running `export SSL_CERT_FILE=<path/to/ca-certificates-file>` and `export SSL_CERT_FILE=<path/to/ca-certificates-file>` in the terminal
3. Set the environment variables permanently by adding the export commands above to your `~/.bashrc` or equivalent.

## Why does this exist?
I needed a Vagrant box with the complete hashistack to use for demo, development and testing.
In order to build cloud native, security minded and dependable services, there exists a killer combination;
 - Containers - (Docker)
 - Simple&Powerful Orchestrator - (Nomad)
 - Service-mesh mTLS - (Consul connect)
 - Security management - (Vault)

### Hashistack:
 - Consul
 - Nomad
 - Vault
 - Terraform
 - Docker CE
 
#### - with a side-play of:
 - Ansible (installed)
 - Packer
 - consul-template

## Contribute
[See here](docs/CONTRIBUTING.md)
