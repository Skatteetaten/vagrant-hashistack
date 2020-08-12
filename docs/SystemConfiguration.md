# Default System Configuration

The following versions of Hashistack components are used for creating the system:

- **consul-template: 0.25.1**
- **consul: 1.8.1**
- **vault: 1.5.0**
- **nomad: 0.12.1**

The file holding the current version can be looked up [here](../ansible/group_vars/all/variables.yml)

**Nomad policies** added can be looked up in the following location: [nomad policies](../ansible/templates/nomad-policies)

**Consul policies** added can be looked up in the following location: [consul policies](../ansible/templates/consul-policies)

By default Consul Acl policies are enabled on the system and the default policy is set to allow.

## How to override the default System Configuration

### Option 1 - env variables
**Use env to toggle prebuild configuration on/off**

When the vagrant box is provisioned, it reads the data from the following environment file `/home/vagrant/.env_default` in order to set up the system. If you wish to override any of the default values then you can do so by adding that variable name and value in [.env](../template/.env) file. The property values in the .env file override the property values present in the .env_default file and thus makes it simple to provision systems that suffice the relevant development needs.


For example, in order to override the **consul acl default policy** from **allow** to **deny**, the following needs to be added to the **.env** file:


**consul_acl_default_policy=deny**


**TF_VAR_consul_acl_default_policy=deny**

### Option 2 - config files
**Override of config files**

It works the way overriding and appending configuration.

You may add any hcl-files to these directories in order to change the configuration
- [template/vagrant/conf/consul/](../template/vagrant/conf/consul/)
- [template/vagrant/conf/nomad/](../template/vagrant/conf/nomad/)
- [template/vagrant/conf/vault/](../template/vagrant/conf/vault/)


Any valid configuration added to these directories will append the configuration, in lexical order.

Adding a file `99-override.hcl` you will ensure it will be appended last, and 00-override.hcl will be read first.
Any valid configuration from [https://www.consul.io/docs/agent/options.html#configuration_files](https://www.consul.io/docs/agent/options.html#configuration_files) will work.


Examples:
- [Consul config override example](../template/example/vagrant/conf/consul/99-override.hcl)
- [Nomad config override example](../template/example/vagrant/conf/nomad/99-override.hcl)
- [Vault config override example](../template/example/vagrant/conf/vault/99-override.hcl)

**NB! Overriding config files will take effect after any env variables prebuilt configuration. Other words Option 2 is applied after Option 1**
