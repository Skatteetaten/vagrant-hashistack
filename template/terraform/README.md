# Terraform

Any configuration of the hashistack is best performed through terraform providers.
- [nomad](https://www.terraform.io/docs/providers/nomad/index.html)
- [vault](https://www.terraform.io/docs/providers/vault/index.html)
- [consul](https://www.terraform.io/docs/providers/consul/index.html)

You put them in this directory and use [../ansible/playbook.yml](../ansible/playbook.yml) to init and run terraform.