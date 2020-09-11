<!-- markdownlint-disable MD041 -->
<p align="center">
 <img width="100px" src="https://www.svgrepo.com/show/58111/cube.svg" align="center" alt="Vagrant-hashistack" />
 <h2 align="center">Vagrant-hashistack Template</h2>
 <p align="center">Starter template for <a href="https://github.com/fredrikhgrelland/vagrant-hashistack">fredrikhgrelland/vagrant-hashistack</a></p>
<p align="center">
    <a href="https://github.com/fredrikhgrelland/vagrant-hashistack-template/actions">
      <img alt="Build" src="https://github.com/fredrikhgrelland/vagrant-hashistack-template/workflows/CI/CD/badge.svg" />
    </a>
    <a href="https://github.com/fredrikhgrelland/vagrant-hashistack/releases">
      <img alt="Releases" src="https://img.shields.io/github/v/release/fredrikhgrelland/vagrant-hashistack?label=latest%20version" />
    </a>
    <a href="https://github.com/fredrikhgrelland/vagrant-hashistack/commits">
      <img alt="Updated" src="https://img.shields.io/github/last-commit/fredrikhgrelland/vagrant-hashistack-template?label=last%20updated" />
    </a>
    <br />
    <br />
    <p align="center">
      <a href="https://github.com/fredrikhgrelland/vagrant-hashistack-template/generate" alt="Clone Template">
            <img src="https://img.shields.io/badge/Github-Clone%20template-blue?style=for-the-badge&logo=github" />
        </a>
    </p>
</p>

## Content
1. [Description - What & Why](#description---what--why)
   1. [Why Does This Exist?](#why-does-this-exist)
   2. [Services](#services)
2. [Install Prerequisites](#install-prerequisites)
   1. [Packages that needs to be pre-installed](#packages-that-needs-to-be-pre-installed)
      1. [MacOS Specific](#macos-specific)
      2. [Ubuntu Specific](#ubuntu-specific)
3. [Configuration](#configuration)
   1. [Startup Scheme](#startup-scheme)
      1. [Detailed Startup Procedure](#detailed-startup-procedure)
   2. [Pre and Post Hashistack Startup Procedure](#pre-and-post-hashistack-startup-procedure)
      1. [Ansible Playbooks Pre and Post Hashistack Startup](#ansible-playbooks-pre-and-post-hashistack-startup)
      2. [Bash Scripts Pre and Post Ansible Playbook](#bash-scripts-pre-and-post-ansible-playbook)
   3. [Pre-packaged Configuration Switches](#pre-packaged-configuration-switches)
      1. [Enterprise vs Open Source Software (OSS)](#enterprise-vs-open-source-software-oss)
      2. [Nomad](#nomad)
      3. [Consul](#consul)
      4. [Vault](#vault)
         1. [Consul Secrets Engine](#consul-secrets-engine)
   2. [Vagrant Box Resources](#vagrant-box-resources)
4. [Usage](#usage)
   1. [Commands](#commands)
   2. [MinIO](#minio)
      1. [Pushing Resources To MinIO With Ansible (Docker image)](#pushing-resources-to-minio-with-ansible-docker-image)
      2. [Fetching Resources From MinIO With Nomad (Docker image)](#fetching-resources-from-minio-with-nomad-docker-image)
   3. [Iteration of the Development Process](#iteration-of-the-development-process)
5. [Test Configuration and Execution](#test-configuration-and-execution)


## Description - What & Why
This template is a starting point, and example, on how to take advantage of the [Hashistack vagrant-box](https://app.vagrantup.com/fredrikhgrelland/boxes/hashistack) to create, develop, and test Terraform-modules within the Hashistack ecosystem.

**Hashistack**, in current repository context, is a set of software products by [HashiCorp](https://www.hashicorp.com/).


> :bulb: If you found this in `fredrikhgrelland/vagrant-hashistack`, you may be interested in the separate repository [vagrant-hashistack-template](https://github.com/fredrikhgrelland/vagrant-hashistack-template/).  
> :warning: If you are reading this in your own repository, go to [If This Is in Your Own Repository](#if-this-is-in-your-own-repository)

### Why Does This Exist?
 This template aims to standardize workflow for building and testing terraform-nomad-modules, using the [fredrikhgrelland/hashistack](https://github.com/fredrikhgrelland/vagrant-hashistack) vagrant-box.


### Services
The default box will start Nomad, Vault, Consul and MinIO bound to loopback and advertising on the IP `10.0.3.10`, which should be available on your local machine.
Port-forwarding for `nomad` on port `4646` should bind to `127.0.0.1` and should allow you to use the nomad binary to post jobs directly.
Consul and Vault have also been port-forwarded and are available on `127.0.0.1` on ports `8500` and `8200` respectively.
Minio is started on port `9000` and shares the `/vagrant` (your repo) from within the vagrant box.

|Service|URL|Token(s)|
|:---|:---:|:---:|
|Nomad| [http://10.0.3.10:4646](http://10.0.3.10:4646)||
|Consul| [http://10.0.3.10:8500](http://10.0.3.10:8500)|master|
|Vault| [http://10.0.3.10:8200](http://10.0.3.10:8200)|master|
|Minio| [http://10.0.3.10:9000](http://10.0.3.10:9000)|minioadmin : minioadmin|


## Install Prerequisites

```text
make install
```

The command, will install:
- [VirtualBox](https://www.virtualbox.org/)
- [Packer](https://www.packer.io/)
- [Vagrant](https://www.vagrantup.com/) with additional plugins
- [Additional software dependent on the OS (Linux, MacOS)](../install/Makefile)

### Packages that needs to be pre-installed

- [Make](https://man7.org/linux/man-pages/man1/make.1.html)
- [Git CLI](https://git-scm.com/book/en/v2/Getting-Started-The-Command-Line)

#### MacOS Specific
- Virtualization must be enabled. [This is enabled by default on MacOS.](https://support.apple.com/en-us/HT203296)
- [Homebrew](https://brew.sh/) must be installed.

#### Ubuntu Specific
- Virtualization must be enabled. [Error if it is not.](https://github.com/fredrikhgrelland/vagrant-hashistack/issues/136)
- Packages [gpg](http://manpages.ubuntu.com/manpages/xenial/man1/gpg.1.html) and [apt](http://manpages.ubuntu.com/manpages/bionic/man8/apt.8.html) must be installed.

---

`NB` _Post installation you might need to reboot your system in order to start the virtual-provider (VirtualBox)_

---


## Configuration

### Startup Scheme
From a thousand foot view the startup scheme will:
1. Start the hashistack and MinIO
2. Run [playbook.yml](dev/ansible/playbook.yml), which in turn runs all ansible-playbooks inside [dev/ansible/](dev/ansible).

> :bulb: Vagrantfile lines 8-11 run the first playbook on startup, and can be changed.  
> :bulb: Below is a detailed description of the _whole_ startup procedure, both user changeable and not.

---

#### Detailed Startup Procedure
_box_ - Comes bundled with the box, not possible to change

_system_ - Provided by the system in automated processes, not possible to change

_user_ - Provided by the user to alter the box or template in some way

|Seq number| What | Provided by | Description |
|:--:|:------------|:------------:|:-----|
|1 |`/home/vagrant/.env_default`|[ _box_ ]| default variables |
|2 |`/vagrant/.env`|[ _user_ ]| variables override, see [Pre-packaged Configuration Switches](#pre-packaged-configuration-switches) for details |
|3 |`/vagrant/.env_override`|[ _system_ ]| variables are overridden for test purposes |
|4 |`/vagrant/dev/vagrant/conf/pre_ansible.sh`|[ _user_ ]| script running before ansible bootstrap procedure, [details](dev/vagrant/conf/pre_bootstrap/README.md) |
|5 |`/vagrant/dev/vagrant/conf/pre_bootstrap/*.yml`|[ _user_ ]| pre bootstrap tasks, running before hashistack software starts, [details](dev/vagrant/conf/README.md) |
|6 |`/etc/ansible/bootstrap.yml`|[ _box_ ]| verify ansible variables and software configuration, run hashistack software and MinIO, & verify that it started correctly,  [link](../ansible/bootstrap.yml) |
|7 |`/vagrant/conf/post_bootstrap/*.yml`|[ _user_ ]| poststart scripts, running after hashistack software has started, [details](dev/vagrant/conf/pre_bootstrap/README.md) |
|8 |`/vagrant/dev/conf/post_ansible.sh`|[ _user_ ]| script running after ansible bootstrap procedure, [details](dev/vagrant/conf/README.md) |
|9 |`/vagrant/ansible/*.yml`|[ _user_ ]| ansible tasks included in playbook, see [Pre-packaged Configuration Switches](#pre-packaged-configuration-switches) for details |

---

### Pre and Post Hashistack Startup Procedure
#### Ansible Playbooks Pre and Post Hashistack Startup
You may change the hashistack configuration or add additional pre and post steps to the ansible startup procedure to match your needs.
Detailed documentation in [dev/vagrant/conf/README.md](dev/vagrant/conf/README.md)

#### Bash Scripts Pre and Post Ansible Playbook
In addition to ansible playbooks, you can also add bash-scripts that will be run before and/or after the ansible provisioning step. This is useful for doing deeper changes to the box pertaining to your needs. Detailed documentation in [dev/vagrant/conf/README.md](dev/vagrant/conf/README.md)


### Pre-packaged Configuration Switches

The box comes [with a set of configuration switches controlled by env variables](https://github.com/fredrikhgrelland/vagrant-hashistack#configuration) to simplify testing of different scenarios and enable staged development efforts.
To change any of these values from their defaults, you may add the environment variable to [.env](dev/.env).

NB: All lowercase variables will automatically get a corresponding  `TF_VAR_` prepended variant for use directly in terraform. [Script](../.github/action/create-env.py)

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

##### Consul Secrets Engine

If `consul_acl_default_policy` has value `deny`, it will also enable [consul secrets engine](https://www.vaultproject.io/docs/secrets/consul) in vault.  
Ansible will provision additional custom roles (admin-team, dev-team), [policies](../ansible/templates/consul-policies) and tokens for test purpose with different access level.

How to generate token:
```text
# generate token for dev team member
vagrant ssh -c 'vault read consul/creds/dev-team'

# generate token for admin team member
vagrant ssh -c 'vault read consul/creds/admin-team'
```

> :bulb: Tokens can be used to access UI (different access level depends on policy attached to the token)

### Vagrant Box Resources
If you get the error message `Dimension memory exhausted on 1 node` or `Dimension CPU exhausted on 1 node`, you might want to increase resources dedicated to your vagrant-box.
To overwrite the default resource-configuration you can add the lines
```hcl
Vagrant.configure("2") do |config|
    config.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpu = 2
    end
end
```
to the bottom of your [Vagrantfile](Vagrantfile), and change `vb.memory` and `vb.cpu` to suit your needs. Any configuration in [Vagrantfile](Vagrantfile) will overwrite the defaults if there is any. [More configuration options](https://www.vagrantup.com/docs/providers/virtualbox/configuration.html).

> :bulb: The defaults can be found in [Vagrantfile.default](Vagrantfile.default).


## Usage
### Commands
There are several commands that help to run the vagrant-box:
- `make install` installs all prerequisites. Run once.

- `make up` provisions a [vagrant-hashistack](https://github.com/fredrikhgrelland/vagrant-hashistack/) box on your machine. After the machine and hashistack are set up it will run the [Startup Scheme](#startup-scheme).

- `make clean` takes down the provisioned box if there is any.

- `make dev` is same as `make up` except that it skips all the tasks within ansible playbook that have the tag `test` and custom_ca. Read more about ansible tags [here](https://docs.ansible.com/ansible/latest/user_guide/playbooks_tags.html).

- `make test`  takes down the provisioned box if there is any and remove tmp files then runs `make up`.

- `make update` downloads the newest version of the [vagrant-hashistack box](https://github.com/fredrikhgrelland/vagrant-hashistack/) from [vagrantcloud](https://vagrantcloud.com/fredrikhgrelland/hashistack).

- `make template_example` runs the example in [template_example/](template_example)

> :bulb: For full info, check [`template/Makefile`](./Makefile).
> :warning: Makefile commands are not idempotent in the context of vagrant-box.  You could face the error of port collisions. Most of the cases it could happen because of the vagrant box has already been running. Run `vagrant destroy -f` to destroy the box.

Once vagrant-box is running, you can use other [options like the Nomad- and Terraform-CLIs to iterate over the deployment in the development stage](#iteration-of-the-development-process).

### MinIO
Minio S3 can be used as a general artifact repository while building and testing within the scope of the vagrantbox to push, pull and store resources for further deployments.

> :warning: Directory `/vagrant` is mounted to minio. Only first level of sub-directories become bucket names.

Resource examples:
- docker images
- compiled binaries
- jar files
- etc...

#### Pushing Resources To MinIO With Ansible (Docker image)
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
[Full example](template_example/dev/ansible/01_build_docker_image.yml)

#### Fetching Resources From MinIO With Nomad (Docker image)
> :bulb: [The artifact stanza](https://www.nomadproject.io/docs/job-specification/artifact) instructs Nomad to fetch and unpack a remote resource, such as a file, tarball, or binary.

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
[Full example](./template_example/conf/nomad/countdash.hcl)

### Iteration of the Development Process

Once you start the box with one of the commands `make dev`, `make up` or `make example`,
you need a simple way how to continuously deploy development changes.

There are several options:

1. **From the local machine**. You can install Hashicorp binaries on the local machine, such as terraform and nomad.
Then you can deploy changes to the vagrant-box using these binaries.

Example terraform:
```text
terraform init
terraform apply
```

Example nomad:
```text
nomad job run countdash.hcl
```

> :warning: _Your local binaries and the binaries in the box might not be the same versions, and may behave differently. [Box versions.](../ansible/group_vars/all/variables.yml)

2. **Using vagrant**. Box instance has all binaries are installed and available in the PATH.
You can use `vagrant ssh` to place yourself inside of the vagrantbox and run commands.

```text
# remote command execution
vagrant ssh default -c 'cd /vagrant; terraform init; terraform apply'

# ssh inside the box, local command execution
vagrant ssh default
cd /vagrant
terraform init
terraform apply
```

> :bulb: `default` is the name of running VM. You could also use VM `id`.
To get vm `id` check `vagrant global-status`.

## Test Configuration and Execution
The tests are run using [Github Actions](https://github.com/features/actions) feature which makes it possible to automate, customize, and execute the software development workflows right in the repository. We utilize the **matrix testing strategy** to cover all the possible and logical combinations of the different properties and values that the components support. The .env_override file is used by the tests to override the values that are available in the .env_default file, as well as the user configurable .env file.


As of today, the following tests are executed:

| Test name                                                                                  | Consul Acl  |  Consul Acl Policy  |  Nomad Acl    | Hashicorp binary
|:------------------------------------------------------------------------------------------:|:------------|:-------------------:|:-------------:|:---------------:|
|    test (consul_acl_enabled, consul_acl_deny, nomad_acl_enabled, hashicorp_oss)            |  true       |  deny               |  true         | Open source     |
|    test (consul_acl_enabled, consul_acl_deny, nomad_acl_enabled, hashicorp_enterprise)     |  true       |  deny               |  true         | enterprise      |
|    test (consul_acl_enabled, consul_acl_deny, nomad_acl_disabled, hashicorp_oss)           |  true       |  deny               |  false        | Open source     |
|    test (consul_acl_enabled, consul_acl_deny, nomad_acl_disabled, hashicorp_enterprise)    |  true       |  deny               |  false        | enterprise      |
|    test (consul_acl_disabled, consul_acl_deny, nomad_acl_enabled, hashicorp_oss)           |  false      |  deny               |  true         | Open source     |
|    test (consul_acl_disabled, consul_acl_deny, nomad_acl_enabled, hashicorp_enterprise)    |  false      |  deny               |  true         | enterprise      |
|    test (consul_acl_disabled, consul_acl_deny, nomad_acl_disabled, hashicorp_oss)          |  false      |  deny               |  false        | Open source     |
|    test (consul_acl_disabled, consul_acl_deny, nomad_acl_disabled, hashicorp_enterprise)   |  false      |  deny               |  false        | enterprise      |

The latest test results can be looked up under the **Actions** tab.

## If This Is in Your Own Repository
If you are reading this from your own repository you should _delete_ this `README.md`, fill out `README_template.md`, and rename `README_template.md` to `README.md`.
