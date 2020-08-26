# Overriding and appending consul configuration

You may add any hcl-files to this directory in order to change the configuration.
Any valid configuration added to this directory will append the configuration, in lexical order.

Adding a file `99-override.hcl` you will ensure it will be appended last, and 00-override.hcl will be read first.
Any valid configuration from [https://www.consul.io/docs/agent/options.html#configuration_files](https://www.consul.io/docs/agent/options.html#configuration_files) will work.
See [example](../../../../template_example/dev/vagrant/conf/consul/99-override.hcl)
