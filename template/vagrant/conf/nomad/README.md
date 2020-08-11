# Overriding and appending nomad configuration

You may add any hcl-files to this directory in order to change the configuration.
Any valid configuration added to this directory will append the configuration, in lexical order.

Adding a file `99-override.hcl` you will ensure it will be appended last, and 00-override.hcl will be read first.
Any valid configuration from [https://www.nomadproject.io/docs/configuration#general-parameters](https://www.nomadproject.io/docs/configuration#general-parameters) will work.

### Example `98-template-plugin.hcl`
```hcl
client {
  template {
    #Remove blacklist in order for allow "plugins" to run. We need curl to run as a plugin in template
    plugin_blacklist = []
  }
}
```

See [example](../../../example/vagrant/conf/nomad/99-override.hcl)