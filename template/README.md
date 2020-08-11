# Starter template for `fredrikhgrelland/hashistack`

This repository can be used as a base for developing services on the hashistack.
On github, you may use the ["Use this template"](https://github.com/fredrikhgrelland/vagrant-hashistack-template/generate) button to generate a new repository from this template.

If you found this in `fredrikhgrelland/vagrant-hashistack`, you may be interested in this separate repository [vagrant-hashistack-template](https://github.com/fredrikhgrelland/vagrant-hashistack-template/generate) button to start a new repository from this repo
.

Documentation on [parent repository](https://github.com/fredrikhgrelland/vagrant-hashistack#usage).

## Customizing and using the vagrant box
The vagrant box ships with a default startup scheme. It will run an ansible playbook to start all services.
You may change the hashistack configuration or add aditional pre and post steps to the startup procedure to match your needs.
Detailed documentation in [vagrant/conf/README.md]()

#### Nomad ACLs

| default   | environment variable  |  value  |
|:---------:|:----------------------|:-------:|
|           | nomad_acl             |  true   |
|           | TF_VAR_nomad_acl      |  true   |
| x         | nomad_acl             |  false  |
| x         | TF_VAR_nomad_acl      |  false  |

To change from the default value, you may add the environment variable to [.env]()

When ACLs in Nomad are enabled the bootstrap token will be available in vault under `secret/nomad/management-token` with the two key-value pairs `accessor-id` and `secret-id`. `secret-id` is the token itself. These can be accessed in several ways:
- From inside the vagrant box with `vault kv get secret/nomad-bootstrap-token`
- From local machine with `vagrant ssh -c vault kv get secret/nomad-bootstrap-token"`
- By going to vault's UI on `localhost:8200`, and signing in with the root token.

#### Consul ACLs and policies

| default   | environment variable             |  value  |
|:---------:|:---------------------------------|:-------:|
|     x     | consul_acl                       |  true   |
|     x     | TF_VAR_consul_acl                |  true   |
|           | consul_acl                       |  false  |
|           | TF_VAR_consul_acl                |  false  |
|     x     | consul_acl_default_policy        |  allow  |
|     x     | TF_VAR_consul_acl_default_policy |  allow  |
|           | consul_acl_default_policy        |  deny   |
|           | TF_VAR_consul_acl_default_policy |  deny   |

To change from the default value, you may add the environment variable to [.env]()



#### Consul secrets engine
If `consul_acl_default_policy` has value `deny`, it will also enable [consul secrets engine](https://www.vaultproject.io/docs/secrets/consul) in vault.  
Ansible will provision additional custom roles (admin-team, dev-team), [policies](../ansible/templates/consul-policies) and tokens for test purpose with different access level.

How to generate token:
```text
# generate token for dev team member
vagrant ssh -c 'vault read consul/creds/dev-team'

# generate token for admin team member
vagrant ssh -c 'vault read consul/creds/admin-team'
```

*Tokens can be used to access UI (different access level depends on role)

### Vagrant box life-cycle
1. `.env_default` - _preloaded_ - default variables
1. `.env` - _user provided_ - variables override
1. `.env_override` - _system provided_ - variables are overridden for test purposes
1. `vagrant/conf/pre_ansible.sh` - _user provided_ - script running before ansible bootstrap procedure
1. `vagrant/conf/pre_bootstrap/*.yml` - _user provided_ - pre bootstrap tasks, running before hashistack software runs and ready
1. `/etc/ansible/bootstrap.yml` - _preloaded_ - verify ansible variables and software configuration, run hashistack software & verify that it started correctly
1. `vagrant/conf/post_bootstrap/*.yml` - _user provided_ - poststart scripts, running after hasistack software runs and ready

TODO: 8. `vagrant/ansible/playbook.yml` - _user provided_ - user's provisioning playbook
