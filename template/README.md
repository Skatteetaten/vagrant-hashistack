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

To use this template you will need Make, Vagrant, and Virtualbox.
`make install` will install all that is needed and is provided as a convenience for Ubuntu 18.04 and MacOS.

## Goals of this template
This template provides a developer with the tools necessary to do three things:
- Build a docker image
- Build a terraform module
- Test and develop these two within a hashistack ecosystem

To achieve this we utilise a vagrant-box built from [fredrikhgrelland/vagrant-hashistack](https://github.com/fredrikhgrelland/vagrant-hashistack/).

## Where do I start?
First of all I would recommend you read the section ["Using the template and box"](#using-the-template-and-box) for a detailed look at the box's features and configurations. Below is a rough step-by-step going from a fresh template to a functioning terraform module. You can find example-code of everything below in [test_example/](test_example/).

Step-by-step:
1. Create a [Dockerfile](https://docs.docker.com/engine/reference/builder/) and put it in `docker/`.
1. Use the box's startup playbooks to build and make the image available within the box. [Startup scheme](#default-startup-scheme). [Example building image](test_example/dev/ansible/01_build_docker_image.yml).
1. Create a [Nomad job specification](https://www.nomadproject.io/docs/job-specification). This should be placed in [conf/nomad/](conf/nomad/README.md). [Example hcl-file](test_example/conf/nomad/countdash.hcl)
1. Use terraform to deploy this job to Nomad. Refer to ["Terraform module requirements"](#terraform-module-requirements) on how to do this. [Example](test_example/example)

## File structure
```text
|-- conf/
|     |-- nomad/        # nomad job specifications
|
|-- dev/                # files used to control testing and development
|   |-- ansible/        # playbooks run at startup
|   |-- vagrant/        # files altering the vagrant-box
|       |-- conf/
|
|-- docker/             # files used to build docker-image
|
|-- example/            # terraform-files using the terraform-module
|
|-- test_example/       # a copy of template, filled with example-code
```

## Terraform module requirements
[Hashiscorp documentation](https://www.terraform.io/docs/modules/index.html)

 This template follows Hashicorp's standards for terraform modules. In short the root should contain a `main.tf`, `variables.tf` and `outputs.tf`. These three form a module. In addition to this there should be an `example/` folder that uses the module. To get a feel for how to use this effectively in our case you can look at the files [main.tf](test_example/main.tf), [variables.tf](test_example/variables.tf), and [outputs.tf](test_example/outputs.tf) from [test_example/](test_example/).

 Project structure:
 ```text
|-- main.tf
|-- variables.tf
|-- outputs.tf
|
|-- example/
|   |-- main.tf
|   |-- variables.tf
|   |-- outputs.tf
```

## Using the template and box

### Commands
There are several commands that help to run the vagrant-box:
- `make install` installs all prerequisites

- `make up` provisions a [vagrant-hashistack](https://github.com/fredrikhgrelland/vagrant-hashistack/) box on your machine. After the machine and hashistack are set up it will run the default [startup scheme](#default-startup-scheme).

- `make clean` take down the provisioned box if there is any.

- `make update` downloads the newest version of the [vagrant-hashistack box](https://github.com/fredrikhgrelland/vagrant-hashistack/) from [vagrantcloud](https://vagrantcloud.com/fredrikhgrelland/hashistack).

- `make example` runs the example in [test_example/](test_example/)

For full info, check `template/Makefile`

`!Note` - Makefile commands are not idempotent in the context of vagrant-box.  You could face the error of port collisions. Most of the cases it could happen because of the vagrant box has already been running.

Once vagrant-box is running, you can use other options like the Nomad- and Terraform-CLIs to iterate over the deployment in the development stage.

### Building and testing docker image
See docker [README.md](docker/README.md).

### Default startup scheme
The default startup scheme will first start the hashistack and MinIO, then run [playbook.yml](dev/ansible/playbook.yml), which in turn will run all ansible-playbooks inside [dev/ansible/](dev/ansible). For more details go [here](dev/ansible/README.md). The code that runs the first playbook can be found in [Vagrantfile](Vagrantfile). Although this is the default we have supplied you with a plethora of options to customize and alter these processes. Below is a detailed description of the __whole__ startup procedure and details.

#### Detailed startup procedure
__Preloaded__ - Comes bundled with the box, not possible to change

__System provided__ - Provided by the system in automated processes, not possible to change

__User provided__ - Provided by the user to alter the box or template in some way

1. `/home/vagrant/.env_default` - _preloaded_ - default variables
1. `vagrant/.env` - _user provided_ - variables override [details](#pre-packaged-configuration-switches)
1. `vagrant/.env_override` - _system provided_ - variables are overridden for test purposes
1. `vagrant/dev/vagrant/conf/pre_ansible.sh` - _user provided_ - script running before ansible bootstrap procedure, [details](dev/vagrant/conf/pre_bootstrap/README.md)
1. `vagrant/dev/vagrant/conf/pre_bootstrap/*.yml` - _user provided_ - pre bootstrap tasks, running before hashistack software starts, [details](dev/vagrant/conf/README.md)
1. `/etc/ansible/bootstrap.yml` - _preloaded_ - verify ansible variables and software configuration, run hashistack software and MinIO, & verify that it started correctly
1. `vagrant/conf/post_bootstrap/*.yml` - _user provided_ - poststart scripts, running after hashistack software has started, [details](dev/vagrant/conf/pre_bootstrap/README.md)
1. `vagrant/dev/conf/pre_ansible.sh` - _user provided_ - script running after ansible bootstrap procedure, [details](dev/vagrant/conf/README.md)
1. `vagrant/ansible/*.yml` - _user provided_ - ansible tasks included in playbook, [details](#pre-and-post-hashistack-procedure)

### Starting a box
The vagrant box ships with a default startup scheme. `make` from this directory will start the box, and run all books in [dev/ansible](dev/ansible) in lexical order (NB: `playbook.yml` is run first, but is only used to run all other playbooks) after the bootstrap-process for the hashistack is done. In the [example](test_example/dev/ansible/playbook.yml) we use it to start terraform which then starts a nomad-job.

### Accessing Consul, Vault, Nomad, and MinIO
The default box will start Nomad, Vault, Consul, and MinIO bound on loopback and advertising on the ip `10.0.3.10`, which should be available on your local machine.
Portforwarding for nomad on port `4646` should bind to `127.0.0.1` and should allow you to use the nomad binary to post jobs directly. Consul and Vault has also been portforwarded, and are also available on `127.0.0.1` on port `8500` and `8200` respectively.
Minio is started on port `9000` and sharing /vagrant (your repo) from within the vagrant box.
- Nomad ui is available on [http://10.0.3.10:4646](http://10.0.3.10:4646) and all links to services should work.
- Consul ui is available on [http://10.0.3.10:8500](http://10.0.3.10:8500)
- Vault ui is available on [http://10.0.3.10:8200](http://10.0.3.10:8200)
- minio ui is available on [http://10.0.3.10:9000](http://10.0.3.10:9000) (minioadmin:minioadmin)

### Pre and post hashistack procedure
You may change the hashistack configuration or add additional pre and post steps to the startup procedure to match your needs.
Detailed documentation in [dev/vagrant/conf/README.md](dev/vagrant/conf/README.md)

### Pre packaged configuration switches

The box comes standard with a set of environment switches to simplify testing of different scenarios and enable staged development efforts.
To change any of these values from their defaults, you may add the environment variable to [.env](dev/.env).

NB: All lowercase variables will automatically get a corresponding TF_VAR_ prepended variant for use directly in terraform.

#### Enterprise vs Open Source Software (OSS)
To use enterprise versions of the hashistack components set the software's corresponding Enterprise-variable to `true` (see below).

#### Nomad

| default   | environment variable  |  value  |
|:---------:|:----------------------|:-------:|
|           | nomad_enterprise      |  true   |
|     x     | nomad_enterprise      |  false  |
|           | nomad_acl             |  true   |
|     x     | nomad_acl             |  false  |

When ACLs are enabled in Nomad the bootstrap token will be available in vault under `secret/nomad/management-token` with the two key-value pairs `accessor-id` and `secret-id`. `secret-id` is the token itself. These can be accessed in several ways:
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
