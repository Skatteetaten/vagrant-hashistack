# Starter template for `fredrikhgrelland/hashistack`

This repository can be used as a base for developing services on the hashistack.
On github, you may use the ["Use this template"](https://github.com/fredrikhgrelland/vagrant-hashistack-template/generate) button to generate a new repository from this template.

If you found this in `fredrikhgrelland/vagrant-hashistack`, you may be interested in this separate repository [vagrant-hashistack-template-dev](https://github.com/fredrikhgrelland/vagrant-hashistack-template/generate) button to start a new repository from this repo
.

Documentation on [parent repository](https://github.com/fredrikhgrelland/vagrant-hashistack#usage).

## Customizing the vagrant box
The vagrant box ships with a default startup scheme. It will run an ansible playbook to start all services.
You may change the hashistack configuration or add aditional pre and post steps to the startup procedure to match your needs.

### Overriding and extending the configuration of the hashistack

- consul [vagrant/conf/hashistack/consul/99-override.hcl](vagrant/conf/hashistack/consul/99-override.hcl)
- nomad [vagrant/conf/hashistack/nomad/99-override.hcl](vagrant/conf/hashistack/nomad/99-override.hcl)
- vault [vagrant/conf/hashistack/vault/99-override.hcl](vagrant/conf/hashistack/vault/99-override.hcl)

You may edit the `99-override.hcl` or add your own.
Any valid configuration added to these directories will be added to their respective services' configuration, in lexical order.

### Pre- and post-startup ansible playbooks
This vagrant box will execute ansible playbooks put in two special directories [vagrant/conf/ansible/playbooks/prestart](vagrant/conf/ansible/playbooks/prestart) and [vagrant/conf/ansible/playbooks/poststart](vagrant/conf/ansible/playbooks/poststart). These playbooks will be executed before and after the box's bundled startup sequence, respectively. This gives the flexibility to configure all aspects of the hashistack as well as run tasks needed for tests or demo purposes as part of `vagrant up` Note; The playbooks are included into the main run, so the syntax in the [example](vagrant/conf/ansible/playbooks/prestart/0-example.yml) must be followed..  
They will be run in lexical order, and prefixing with numbers is a good way to get the order you want.
