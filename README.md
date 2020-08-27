<p align="center">
 <img width="100px" src="https://www.svgrepo.com/show/143601/cube.svg" align="center" alt="Vagrant-hashistack" />
 <h2 align="center">Vagrant-hashistack</h2>
 <p align="center">Hashistack in one click for development & testing</p>
</p>
<p align="center">
    <a href="https://github.com/fredrikhgrelland/vagrant-hashistack/actions">
      <img alt="Build" src="https://github.com/fredrikhgrelland/vagrant-hashistack/workflows/CI/CD/badge.svg" />
    </a>
    <a href="https://github.com/fredrikhgrelland/vagrant-hashistack/releases">
      <img alt="Releases" src="https://img.shields.io/badge/dynamic/json?label=latest%20version&query=%24.current_version.version&url=https%3A%2F%2Fapp.vagrantup.com%2Fapi%2Fv1%2Fbox%2Ffredrikhgrelland%2Fhashistack" />
    </a>
    <a href="https://github.com/fredrikhgrelland/vagrant-hashistack/commits">
      <img alt="Updated" src="https://img.shields.io/badge/dynamic/json?label=updated&query=%24.current_version.updated_at&url=https%3A%2F%2Fapp.vagrantup.com%2Fapi%2Fv1%2Fbox%2Ffredrikhgrelland%2Fhashistack" />
    </a>
    <br />
    <br />
    <p align="center">
      <a href="https://app.vagrantup.com/fredrikhgrelland/boxes/hashistack" alt="Download og Vagrant Cloud">
            <img src="https://img.shields.io/badge/Download%20on-Vagrant%20Cloud-orange?style=for-the-badge&logo=vagrant" />
        </a>
      <a href="https://github.com/fredrikhgrelland/vagrant-hashistack-template/generate" alt="Clone Template">
            <img src="https://img.shields.io/badge/Github-Clone%20template-blue?style=for-the-badge&logo=github" />
        </a>
    </p>
</p>

#

This vagrant box aims to make it dead simple to start a hashistack and emulate how services will be deployed to production.

---
*This repository will publish a new [template](template/README.md) into [fredrikhgrelland/vagrant-hashistack-template](https://github.com/fredrikhgrelland/vagrant-hashistack-template) repo on every release.*

---

> 🚧 - current vagrant box runs consul, nomad and vault in `dev` (development) mode.
- [consul development mode](https://learn.hashicorp.com/consul/getting-started/agent)
- [nomad development mode](https://learn.hashicorp.com/nomad/getting-started/running)
- [vault development mode](https://www.vaultproject.io/docs/concepts/dev-server)
---

## Content

1. [Description - what & why](#description---what--why)
    1. [Services](#services)
    2. [Why does this exist?](#why-does-this-exist)
    3. [Installed stack](#installed-stack)
2. [Install prerequisites](#install-prerequisites)
    1. [General requirements](#general-requirements)
        1. [Proxy](#proxy)
    2. [Linux requirements](#linux-requirements)
    3. [MacOS requirements](#macos-requirements)
    4. [Windows requirements](#windows-requirements)
3. [Build](#build)
4. [Configuration](#configuration)
    1. [Default Configuration](#default-configuration)
    2. [Override default configuration](#override-default-configuration)
        1. [ENV variables](#option-1---env-variables)
        2. [Config files](#option-2---config-files)
5. [Usage](#usage)
    1. [Starting a plain default box](#option-1-starting-a-plain-default-box)
    2. [Starting a new project based on the template](#option-2-starting-a-new-project-based-on-the-template)
6. [Test](#test)
    1. [Local run](#local-run)
    2. [CI pipeline run](#ci-pipeline-run)
        1. [CI test configuration](#ci-test-configuration)
8. [Diagram](#diagram)
9. [Contribute](#contribute)

## Description - what & why

This repository will build a [base-box](https://app.vagrantup.com/fredrikhgrelland/boxes/hashistack) for different projects to extend on.
The base-box contains components, and a setup that makes it ideal for working with the hashistack.

**Hashistack**, in current repository context, is a set of software products by [HashiCorp](https://www.hashicorp.com/).

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

### Why does this exist?

We needed a Vagrant box with the complete hashistack to use for demo, development and testing.
In order to build cloud native, security minded and dependable services, there exists a killer combination;
- Containers - ([Docker](https://www.docker.com/))
- Simple&Powerful Orchestrator - ([Nomad](https://www.nomadproject.io/))
- Service-mesh mTLS - ([Consul connect](https://www.consul.io/docs/connect))
- Secrets management - ([Vault](https://www.vaultproject.io/))

### Installed stack

- [Consul](https://www.consul.io/)
- [Nomad](https://www.nomadproject.io/)
- [Vault](https://www.vaultproject.io/)
- [Terraform](https://www.terraform.io/)
- [Docker CE](https://www.docker.com/)

**with a side-play of**

- [Ansible](https://www.ansible.com/)
- [Packer](https://www.packer.io/)
- [Consul-template](https://github.com/hashicorp/consul-template)
- [Minio](https://min.io/)

## Install prerequisites

```text
make install
```

The command, will install:
- [VirtualBox](https://www.virtualbox.org/)
- [Packer](https://www.packer.io/)
- [Vagrant](https://www.vagrantup.com/) with additional plugins
- [Additional software dependent on the OS (Linux, MacOS)](install/Makefile)


### General requirements

You will need to have the following binaries pre-installed:

- [Make](https://man7.org/linux/man-pages/man1/make.1.html)
- [Git CLI](https://git-scm.com/book/en/v2/Getting-Started-The-Command-Line)

---

`NB` **Post installation you might need to reboot your system in order to start the virtual-provider (VirtualBox)**

*The rest of the Requirements are operative system dependent*

---

#### Proxy

If you for any reason find yourself behind a transparent proxy you need to set the environment variables `SSL_CERT_FILE` and `CURL_CA_BUNDLE`. You have three options:
- Prefix `vagrant up`; `SSL_CERT_FILE=<path/to/ca-certificates-file> CURL_CA_BUNDLE=<path/to/ca-certificates-file> vagrant up`
- Set the environment variables in your current session by running `export SSL_CERT_FILE=<path/to/ca-certificates-file>` and `export CURL_CA_BUNDLE=<path/to/ca-certificates-file>` in the terminal. Eg:`export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt`
- Set the environment variables permanently by adding the above export commands to your `~/.bashrc` or equivalent.

### Linux requirements

- Virtualization must be enabled. [Error if it is not.](https://github.com/fredrikhgrelland/vagrant-hashistack/issues/136)
- Packages `gpg` and `apt` must be installed.

### MacOS requirements

- Virtualization must be enabled. [This is enabled by default on MacOS.](https://support.apple.com/en-us/HT203296)
- [Homebrew](https://brew.sh/) must be installed.

### Windows requirements

todo

## Build

```text
make build
```

Command above will build a vagrant box based on [fredrikhgrelland/bionic64-ansible-docker](https://app.vagrantup.com/fredrikhgrelland/boxes/bionic64-ansible-docker). The packaged box will be locally available at ´packer/output-hashistack/package.box´

**Note**: You can refer to the [configuration](#configuration) section in order to get a comprehensive overview of the default configurations with which the system is set up.
The section also provides information about steps for overriding the default system configuration.

## Configuration

In most cases, users need to customize vagrant-box's services configuration.

Scenarios for customization:
```text
1. consul(enterprise) with consul_acl = enabled and default acl policy = deny
2. nomad(oss) with nomad_acl = false
3. vault(enterprise), unsealed and integrated with nomad and consul, the way that it manages their secrets/tokens
```

In order to simplify making such changes in the configuration, we provide `switches`.
These are sort of switches which are controlled by `env` variables and provide the user with the opportunity to quickly switch between the configuration setup.

Supported switches are listed under `# Control box features` section in the following [file](ansible/templates/.env_default.j2)

---

### Default Configuration

- [.env_default.j2](ansible/templates/.env_default.j2)
- [hashistack component versions](ansible/group_vars/all/variables.yml)
- [nomad policies](ansible/templates/nomad-policies)
- [consul policies](ansible/templates/consul-policies)

**Consul**:  
- Open source version
- ACL [enabled=true](https://www.consul.io/docs/agent/options#acl_enabled)
- [default_policy=allow](https://www.consul.io/docs/agent/options#acl_default_policy)

**Nomad**:
- Open source version
- ACL [enabled=false](https://www.nomadproject.io/docs/configuration/acl#enabled)
- Integrated with Consul, using token

**Vault**
- Open source version
- Unsealed

### Override default configuration

#### Option 1 - env variables

**Use env to switch prebuild configuration on/off**

When the vagrant box is provisioned, it reads the data from the following environment file `/home/vagrant/.env_default` in order to set up the system.
If you wish to override any of the default values then you can do so by adding that variable name and value in [.env](template/dev/.env) file.
The property values in the `.env` file override the property values present in the `.env_default` file and thus makes it simple to provision systems that suffice the relevant development needs.


For example, in order to override the **consul acl default policy** from **allow** to **deny**, the following needs to be added to the `.env` file:

```text
consul_acl_default_policy=deny
```


#### Option 2 - config files

**Overriding config files***

It is possible to add and/or override the hashistack components' configuration files. See documentation [here](template/dev/vagrant/conf/README.md).

`NB!` *Overriding config files will take effect at last. In other words, config files(Option 2) will override any configuration which were setup by the env variables(Option 1)*

## Usage

Vagrant-hashistack provides these features:
- Deploy & test terraform modules
- Deploy & test nomad jobs
- Upload files to Minio
- Test automation

### Option-1 Starting a plain default box

To get a running VM using the latest release of this box run

```text
vagrant init fredrikhgrelland/hashistack
ANSIBLE_ARGS='--extra-vars "local_test=true"' vagrant up --provision
```

The first command will add a file called `Vagrantfile` to your directory, and `vagrant up` will start a box based on the specifications of that file.

`NB` **If you are behind a transparent proxy, follow [proxy documentation](#proxy)**

### Option-2 Starting a new project based on the template

To see a full example of how to start a new project based on this box go to [template-repo](https://github.com/fredrikhgrelland/vagrant-hashistack-template).

`NB` **If you are behind a transparent proxy, follow [proxy documentation](#proxy)**

## Test

There are two options how to run tests:
- run all tests on local machine
- run all tests in CI (env variable CI)

Options are controlled by environment variable `CI`.

### Local run

`CI` env variable is not set.

```text
make test
```

The above command runs the tests by starting the [countdash](https://www.nomadproject.io/docs/integrations/consul-connect/) consul-connect example. If ´packer/output-hashistack/package.box´ does not exist, it will run ´make build´.

Pay attention that we pass [extra-vars](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#id35) `--tags=local_test=true` to the ansible provisioner.
[Full example](https://github.com/fredrikhgrelland/vagrant-hashistack/blob/master/template/Makefile#L36)

### CI pipeline run

`CI` env variable set to any non-null value.

```text
make test
```

The tests are run using [Github Actions](https://github.com/features/actions) feature which makes it possible to automate, customize, and execute the software development workflows right in the repository.

We utilize the **matrix testing strategy** to cover all the possible and logical combinations of the different properties and values that the components support.
The `.env_override` file is used by the tests to override the values that are available in the `.env_default` file, as well as the user configurable `.env` file.

#### CI test configuration

As of today, the following tests are executed whenever a `Pull request` is created :

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

The latest test results can be looked up under the Actions tab [Actions](https://github.com/fredrikhgrelland/vagrant-hashistack/actions)

## Diagram

![img](docs/image/vagrant-hashistack.png)

## Contribute

[See here](docs/CONTRIBUTING.md)
