# Starter template for `fredrikhgrelland/hashistack`

This repository can be used as a base for developing services on the hashistack.
On github, you may use the
<a href="https://github.com/fredrikhgrelland/vagrant-hashistack-template/generate" alt="Use this template">
<img src="https://img.shields.io/badge/Use this template-2ea44f"/></a>
 button to generate a new repository from this template.

If you found this in `fredrikhgrelland/vagrant-hashistack`, you may be interested in this separate repository [vagrant-hashistack-template](https://github.com/fredrikhgrelland/vagrant-hashistack-template/generate) button to start a new repository from this repo
.

Documentation on [parent repository](https://github.com/fredrikhgrelland/vagrant-hashistack#usage).

## Prerequisites

To run this box you will need Make, Vagrant, Virtualbox.
`make install` will install all that is needed and is provided as a convenience for Ubuntu 18.04 and MacOS.

## Customizing and using the vagrant box

### Building and testing docker image
See docker [README.md](docker/README.md).

### Starting a box
The vagrant box ships with a default startup scheme. `make` from this directory will start the box, and it will run all books in [dev/ansible](dev/ansible) in lexical order (NB: `playbook.yml` is run first, but is only used to run all other playbooks) after the bootstrap-process for the hashistack is done. In the [example](test_example/dev/ansible/playbook.yml) we use it to start terraform which then starts a nomad-job.

### Pre and post hashistack procedure
You may change the hashistack configuration or add aditional pre and post steps to the startup procedure to match your needs.
Detailed documentation in [dev/vagrant/conf/README.md](dev/vagrant/conf/README.md)

### Pre packaged configuration switches

The box comes standard with a set of environment switches to simplify testing of different scenarios and enable staged development efforts.

NB: All lowercase variables will automatically get a corresponding TF_VAR_ prepended variant for use directly in terraform.
To change from the default value, you may add the environment variable to [.env](dev/.env)

#### Enterprise vs Open Source Software (OSS)
As long as Enterprise is not set to `true` the box will utilise OSS version of the binaries.

#### Nomad

| default   | environment variable  |  value  |
|:---------:|:----------------------|:-------:|
|           | nomad_enterprise      |  true   |
|     x     | nomad_enterprise      |  false  |
|           | nomad_acl             |  true   |
|     x     | nomad_acl             |  false  |

When ACLs in Nomad are enabled the bootstrap token will be available in vault under `secret/nomad/management-token` with the two key-value pairs `accessor-id` and `secret-id`. `secret-id` is the token itself. These can be accessed in several ways:
- From inside the vagrant box with `vault kv get secret/nomad-bootstrap-token`
- From local machine with `vagrant ssh -c vault kv get secret/nomad-bootstrap-token"`
- By going to vault's UI on `localhost:8200`, and signing in with the root token.

#### Consul

| default   | environment variable             |  value  |
|:---------:|:---------------------------------|:-------:|
|           | consul_enterprise                |  true   |
|     x     | consul_enterprise                |  false  |
|     x     | consul_acl                       |  true   |
|           | consul_acl                       |  false  |
|     x     | consul_acl_default_policy        |  allow  |
|           | consul_acl_default_policy        |  deny   |

#### Vault

| default   | environment variable             |  value  |
|:---------:|:---------------------------------|:-------:|
|           | vault_enterprise                 |  true   |
|     x     | vault_enterprise                 |  false  |

##### Consul secrets engine

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

## Minio
Minio S3 can be used as a general artifact repository while building and testing within the scope of the vagrantbox to push, pull and store resources for further deployments.

`NOTE` - Directory `/vagrant` is mounted to minio. Only first level of sub-directories become bucket names.

Resource examples:
- docker images
- compiled binaries
- jar files
- etc...

### Pushing resources to Minio with Ansible [Docker image]
Push(archive) of docker image.
```yaml
# NB! Folder /vagrant is mounted to Minio
# Folder `dev` is going to be a bucket name
- name: Create tmp if it does not exist
  file:
    path: /vagrant/dev/tmp
    state: directory
    mode: '0755'
    owner: vagrant
    group: vagrant

- name: Archive docker image
  docker_image:
    name: docker_image
    tag: local
    archive_path: /vagrant/dev/tmp/docker_image.tar
    source: local
```
[Full example](./test_example/dev/ansible/01_build_docker_image.yml)

### Fetching resources from Minio with Nomad [Docker image]
> [The artifact stanza](https://www.nomadproject.io/docs/job-specification/artifact) instructs Nomad to fetch and unpack a remote resource, such as a file, tarball, or binary.

Example:
```hcl
task "web" {
  driver = "docker"
  artifact {
    source = "s3::http://127.0.0.1:9000/dev/tmp/docker_image.tar"
    options {
      aws_access_key_id     = "minioadmin"
      aws_access_key_secret = "minioadmin"
    }
  }
  config {
    load = "docker_image.tar"
    image = "docker_image:local"
  }
}
```
[Full example](./test_example/conf/nomad/countdash.hcl)
## Vagrant box life-cycle
1. `/home/vagrant/.env_default` - _preloaded_ - default variables
1. `vagrant/.env` - _user provided_ - variables override
1. `vagrant/.env_override` - _system provided_ - variables are overridden for test purposes
1. `vagrant/dev/vagrant/conf/pre_ansible.sh` - _user provided_ - script running before ansible bootstrap procedure
1. `vagrant/dev/vagrant/conf/pre_bootstrap/*.yml` - _user provided_ - pre bootstrap tasks, running before hashistack software runs and ready
1. `/etc/ansible/bootstrap.yml` - _preloaded_ - verify ansible variables and software configuration, run hashistack software & verify that it started correctly
1. `vagrant/conf/post_bootstrap/*.yml` - _user provided_ - poststart scripts, running after hasistack software runs and ready
1. `vagrant/dev/conf/pre_ansible.sh` - _user provided_ - script running after ansible bootstrap procedure
1. `vagrant/ansible/*.yml` - _user provided_ - ansible tasks included in playbook
