# Default System Configuration

The following versions of Hashistack components are used for creating the system:

- **consul-template: 0.25.1**
- **consul: 1.8.1**
- **vault: 1.5.0**
- **nomad: 0.12.1**

The file holding the current version can be looked up [here](../ansible/group_vars/all/variables.yml)

**Nomad policies** added can be looked up in the following location: [nomad policies](../ansible/templates/nomad-policies/)

**Consul policies** added can be looked up in the following location: [consul policies](../ansible/templates/consul-policies/)

By default Consul Acl policies are enabled on the system and the default policy is set to allow.

## How to override the default System Configuration

When the vagrant box is provisioned, it reads the data from the following environment file [.env_default](../ansible/template/.env_default) in order to set
up the system. If you wish to override any of the default values then you can do so by adding that variable name and value in [.env](../ansible/template/test/.env) file. The property values in the .env file override the property values present in the .env_default file and thus makes it super easy to provision systems that suffice the relevant development needs.


For example, in order to override the **consul acl default policy** from **allow** to **deny**, the following needs to be added to the **.env** file:


**consul_acl_default_policy=deny**


**TF_VAR_consul_acl_default_policy=deny**