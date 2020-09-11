# Cheat-sheet

## Content
1. [Vagrant](#vagrant)
2. [Terraform](#terraform)
3. [Nomad](#nomad)
4. [Consul](#consul)
5. [Vault](#vault)

## Vagrant
[Source](https://gist.github.com/wpscholar/a49594e2e2b918f4d0c4#file-vagrant-cheat-sheet-md)

Typing `vagrant` from the command line will display a list of all available commands.

Be sure, you are in the same directory as the Vagrantfile when running these commands!

### Creating a VM
- `vagrant init`           -- Initialize Vagrant with a Vagrantfile and ./.vagrant directory, using no specified base image. Before you can do vagrant up, you'll need to specify a base image in the Vagrantfile.
- `vagrant init <boxpath>` -- Initialize Vagrant with a specific box. To find a box, go to the [public Vagrant box catalog](https://app.vagrantup.com/boxes/search). When you find one you like, just replace it's name with boxpath. For example, `vagrant init ubuntu/trusty64`.

### Starting a VM
- `vagrant up`                  -- starts vagrant environment (also provisions only on the FIRST vagrant up)
- `vagrant resume`              -- resume a suspended machine (vagrant up works just fine for this as well)
- `vagrant provision`           -- forces reprovisioning of the vagrant machine
- `vagrant reload`              -- restarts vagrant machine, loads new Vagrantfile configuration
- `vagrant reload --provision`  -- restart the virtual machine and force provisioning

### Getting into a VM
- `vagrant ssh`           -- connects to machine via SSH
- `vagrant ssh <boxname>` -- If you give your box a name in your Vagrantfile, you can ssh into it with boxname. Works from any directory.

### Stopping a VM
- `vagrant halt`        -- stops the vagrant machine
- `vagrant suspend`     -- suspends a virtual machine (remembers state)

### Cleaning Up a VM
- `vagrant destroy`     -- stops and deletes all traces of the vagrant machine
- `vagrant destroy -f`   -- same as above, without confirmation

### Boxes
- `vagrant box list`              -- see a list of all installed boxes on your computer
- `vagrant box add <name> <url>`  -- download a box image to your computer
- `vagrant box outdated`          -- check for updates vagrant box update
- `vagrant boxes remove <name>`   -- deletes a box from the machine
- `vagrant package`               -- packages a running virtualbox env in a reusable box

### Saving Progress
-`vagrant snapshot save [options] [vm-name] <name>` -- vm-name is often `default`. Allows us to save so that we can rollback at a later time

### Tips
- `vagrant -v`                    -- get the vagrant version
- `vagrant status`                -- outputs status of the vagrant machine
- `vagrant global-status`         -- outputs status of all vagrant machines
- `vagrant global-status --prune` -- same as above, but prunes invalid entries
- `vagrant provision --debug`     -- use the debug flag to increase the verbosity of the output
- `vagrant push`                  -- yes, vagrant can be configured to [deploy code](http://docs.vagrantup.com/v2/push/index.html)!
- `vagrant up --provision | tee provision.log`  -- Runs `vagrant up`, forces provisioning and logs all output to a file

### Notes
- If you are using [VVV](https://github.com/varying-vagrant-vagrants/vvv/), you can enable xdebug by running `vagrant ssh` and then `xdebug_on` from the virtual machine's CLI.

## Terraform
For installation see [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).

### Run `.tf` files
- `terraform init`     -- automatically downloads and install any Providers binary for the providers in use in the config
- `terraform plan`     -- see the execution plan before applying it (if run again with no changes in config it will tell you no changes made)
- `terraform apply`    -- will apply and create resources. IMPORTANT! Generates a 'terraform.tfstate' file that keeps track of IDs of created resources

### Destroy resources
- `terraform destroy`  -- behaves like 'apply' but only as all of the resources have been removed from config
- `terraform taint <resource.id>` -- to manually destroy and recreate a resource ('resource.id' could be 'aws_instance.example')

### Check output
- `terraform output` -- query the output data that is usually generated when 'apply' is called. _NB! Migth need to run `terraform refresh` to update the state with new output variables_.

### Tips
- `terraform version`  -- get terraform version. `version` can be replaced with `-v`.
- `terraform show`     -- to inspect the current the state of resources. Can also be manually done with 'terraform state'
- `terraform fmt`      -- formatting file (prettify)
- `terraform validate` -- checking the file for errors in syntax
- `terraform refresh`  -- update the state file of your infrastructure with metadata that matches the physical resources they are tracking.

## Nomad
- `nomad agent -dev`                    -- start agent in dev mode
- `nomad agent -config server.hcl`      -- config server only
- `nomad agent -config client.hcl`      -- config client only
- `nomad node-status`                   -- inspect clients
- `nomad server-members`                -- inspect servers
- `nomad server-members -detailed`      -- inspect servers detailed
- `nomad plan`                          -- plan a nomad job
- `nomad run`                           -- run a nomad job
- `nomad stop`                          -- stop a nomad job
- `nomad status`                        -- get job status
- `nomad status -evals`                 -- get job status
- `nomad eval-status`                   -- get evaluation status
- `nomad logs`                          -- get allocated logs
- `sudo systemctl restart nomad`        -- start service
- `journalctl -u nomad`                 -- check logs

## Consul
For installation see [Install Consul](https://www.consul.io/docs/install).

### Validation
`consule validate`                  --performs a thorough sanity test on Consul configuration files.
- `consul validate /etc/consul.d/*` -- validates the config

### Interaction
- `consul members`                             -- show all cluster members
- `consul members --http-addr=172.17.0.1:8500` -- check a specific cluster member

- `consul catalog datacenters` -- lists all known datacenters
- `consul catalog nodes`       -- lists all nodes in the given datacenter
- `consul catalog services`    -- lists all registered services in a datacenter

### Proxy
One way to connect to a [Nomad service](https://www.nomadproject.io/docs/job-specification/service) that uses a [`sidecar_service`](https://www.nomadproject.io/docs/job-specification/sidecar_service) is to use a proxy.
- `consul connect proxy -service=<any-costum-name> -upstream=<nomad-service-name:<port> -log-level=TRACE` -- using a proxy to connect to a service which will be available on the defined `<port>`. 

### Tips
- `consul version` -- get the consul version. `version` can be replaced with `-v`.
- `consul info`                   -- provides debugging information for operators.

## Vault
- `vault server -dev`                                   -- start server in dev mode
- `vault write secret/<name of secret> <data kv pairs>` -- write key value pair
- `vault read secret/<name of secret>`                  -- read secret
- `vault delete secret/<name of secret>`                -- delete secret
- `vault mounts`                                        -- list mounts
- `vault token-create`                                  -- create token
- `vault token-revoke`                                  -- revoke token
- `vault auth <token>`                                  -- authenticate token
