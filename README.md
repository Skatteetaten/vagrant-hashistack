![Build vagrantbox](https://github.com/fredrikhgrelland/vagrant-hashistack/workflows/Build%20vagrantbox/badge.svg) ![Publish vagrantbox](https://github.com/fredrikhgrelland/vagrant-hashistack/workflows/Publish%20vagrantbox/badge.svg)
# vagrant-hashistack
### WARNING: Under heavy development. Do not use.
### TL;DR
This vagrant box aims to make it dead simple to start a hashistack in a "production state."

## Build & Test
`make install` will download and install all prerequisites (virtualbox, vagrant) You may want to reboot now!

`make build` will build a vagrant box based on hashicorp/bionic64 and push it to [fredrikhgrelland/hashistack](https://app.vagrantup.com/fredrikhgrelland/boxes/hashistack)

`make build_push` will build and push to vagrant cloud. Requires environment variable VAGRANT_CLOUD_TOKEN to be set.

`make test` (dependent on a prior `make build`) will add the built box as local/hashistack, run it and start the [countdash](https://www.nomadproject.io/docs/integrations/consul-connect/) consul-connect example.

## Usage
This is meant to be used as a base-box for different projects to extend on. See [Vagrantfile](./Vagrantfile) for a complete example.

Requirements:
Private network `10.0.3.10` on `eth1`
Port forwarding og `4646` and `8500` to `127.0.0.1`

This box will autostart Consul, Nomad and Docker ready for consul-connect enabled services.
Nomad and Consul bind on loopback and advertise on the ip `10.0.3.10` which should be available on your local machine.
Portforwarding for nomad on port `4646` should bind to `127.0.0.1` and should allow you to use the nomad binary to post jobs directly.
- Nomad ui is available on [http://10.0.3.10:4646](http://10.0.3.10:4646) and all links to services should work.
- Consul ui is available on [http://10.0.3.10:8500](http://10.0.3.10:8500)

## Why do this exist?
I needed a Vagrant box with the complete hashistack to use for demo and development.
In order to build cloud native, security minded and dependable services, there exists a killer combination;
 - Containers - (Docker)
 - Simple&Powerful Orchestrator - (Nomad)
 - Service-mesh mTLS - (Consul connect)

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
