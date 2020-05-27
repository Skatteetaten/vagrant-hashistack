# vagrant-hashistack
WARNING: Under heavy development. Do not use.

## Why do this exist?
I needed a Vagrant box with the complete hashistack to use for demo and development.
In order to build cloud native dependable services with security in focus there exists a killer combination;
 - Containers
 - Simple&Powerful Orchestrator
 - Service-mesh mTLS
 
This vagrant box aims to make it dead simple to get all that set up as close to production state while keeping it dead simple to iterate on the services.

The stack is as follows:
 - Consul
 - Nomad
 - Vault
 - Terraform
 - Docker CE
 
With the side-play of:
 - Ansible (installed)
 - Packer
 - consul-template