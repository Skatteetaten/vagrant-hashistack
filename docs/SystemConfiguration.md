# Default System Configuration

The following versions of Hashistack components are used for creating the system:

- **consul-template: 0.25.1**
- **consul: 1.8.1**
- **vault: 1.5.0**
- **nomad: 0.12.1**

The file holding the current version can be looked up [here](../ansible/group_vars/all/variables.yml)

#### **Nomad policies** added can be looked up in the following location: [nomad policies](../ansible/templates/nomad-policies/)

#### **Consul policies** added can be looked up in the following location: [consul policies](../ansible/templates/consul-policies/)

#### By default Consul Acl policies are enabled on the system and the default policy is set to allow.

# How to override the default System Configuration

When the vagrant box is provisioned it reads the data from the following environment file [.env_default](../ansible/template/.env_default) inorder to set
up the system. If you wish to override any of the default values then you can do so by adding that variable name and value in [.env](../ansible/template/test/.env) file. The property values in the .env file override the property values present in the .env_default file and thus makes it super easy to provision sytems that suffice the relevant development needs.<br/><br/>
For example, inorder to override the **consul acl default policy** from **allow** to **deny**, the following needs to be added to the **.env** file:<br/>
**consul_acl_default_policy=deny**<br/>
**TF_VAR_consul_acl_default_policy=deny**<br/>

# Test Configuration and Execution
The tests are run using [Github Actions](https://github.com/features/actions) feature which makes it possible to automate, customize, and execute the software development workflows right in the repository. We utilize the **matrix testing strategy** to cover all the possible and logical combinations of the different properties and values that the components support.The [.env_override](../ansible/template/.env_override) file is used by the tests to override the values that are available in the .env_default file.<br/>

As of today, the following tests are executed whenever a Pull request is created :<br/>

1. test (consul_acl_enabled, consul_acl_allow, nomad_acl_enabled) : Here the tests are run on a system which is configured such that the consul policy is **enabled**, consul default acl policy is set to **allow** and nomad acl policy is **enabled**.<br/>

2. test (consul_acl_enabled, consul_acl_allow, nomad_acl_disabled) : Here the tests are run on a system which is configured such that the consul policy is **enabled**, consul default acl policy is set to **allow** and nomad acl policy is **disabled**.<br/>

3. test (consul_acl_enabled, consul_acl_deny, nomad_acl_enabled) : Here the tests are run on a system which is configured such that the consul policy is **enabled**, consul default acl policy is set to **deny** and nomad acl policy is **enabled**.<br/>

4. test (consul_acl_enabled, consul_acl_deny, nomad_acl_disabled) : Here the tests are run on a system which is configured such that the consul policy is **enabled**, consul default acl policy is set to **deny** and nomad acl policy is **disabled**.<br/>

5. test (consul_acl_disabled, consul_acl_allow, nomad_acl_enabled) : Here the tests are run on a system which is configured such that the consul policy is **disabled**, consul default acl policy is set to **allow** and nomad acl policy is **enabled**.<br/>

6. test (consul_acl_disabled, consul_acl_allow, nomad_acl_disabled) : Here the tests are run on a system which is configured such that the consul policy is **disabled**, consul default acl policy is set to **allow** and nomad acl policy is **disabled**.<br/>

The latest test results can be looked up under the Actions tab [Actions](https://github.com/fredrikhgrelland/vagrant-hashistack/actions)