# Development template for `fredrikhgrelland/hashistack`

This template can be used as a base for developing services on the hashistack.
If you found this in `fredrikhgrelland/vagrant-hashistack`, you may be interested in this separate repository [vagrant-hashistack-template-dev](https://github.com/fredrikhgrelland/vagrant-hashistack-template-dev).
Documentation on [parent repository](https://github.com/fredrikhgrelland/vagrant-hashistack#usage).

## Usage
### Start box

- `make up`, starts box based on files in this repo.

[Vagrantfile](Vagrantfile) is the main file, and specifies that we want to use the latest released version of the box from [vagrant-hashistack](https://github.com/fredrikhgrelland/vagrant-hashistack), and how much resources we want to give it.

The box will start Vault, Consul and Nomad and then the box will be ready for consul-connect enabled services.
Nomad, Vault and Consul bind on loopback and advertise on the ip `10.0.3.10` which should be available on your local machine.

Portforwarding for nomad on port `4646` should bind to `127.0.0.1` and should allow you to use the nomad binary to post jobs directly.
- Nomad ui is available on [http://10.0.3.10:4646](http://10.0.3.10:4646) and all links to services should work.
- Consul ui is available on [http://10.0.3.10:8500](http://10.0.3.10:8500)
- Vault ui is available on [http://10.0.3.10:8200](http://10.0.3.10:8200)


### Default master tokens

The master token for `Consul` and `Vault` is `master`.


### If you are behind a transparent proxy

If you for any reason find yourself behind a transparent proxy you need to set the environment variables `SSL_CERT_FILE` and `CURL_CA_BUNDLE`. You have three options:
- Prefix `vagrant up`; `SSL_CERT_FILE=<path/to/ca-certificates-file> CURL_CA_BUNDLE=<path/to/ca-certificates-file> vagrant up`
- Set the environment variables in your current session by running `export SSL_CERT_FILE=<path/to/ca-certificates-file>` and `export CURL_CA_BUNDLE=<path/to/ca-certificates-file>` in the terminal. Eg:`export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt`
- Set the environment variables permanently by adding the export commands above to your `~/.bashrc` or equivalent.


### Change configuration of hashistack

- consul `conf/consul/99-override.hcl`
- nomad `conf/nomad/99-override.hcl`
- vault `conf/vault/99-override.hcl`

You may edit the `99-override.hcl` or add you own.
Any valid configuration added to these directories will be added and lexically merged.

### Pre- and post-startup playbooks
This vagrantbox will execute ansible playbooks put in two special directories `conf/ansible/playbooks/prestart` and `conf/ansible/playbooks/poststart`. This gives the flexibility to configure all aspects of the hashistack as well as run tasks needed for tests or demo purposes as part of `vagrant up` Note; The playbooks are included into the main run, so the syntax in the [example](/playbooks/prestart/0-example.yml) must be followed.
They will be run in lexical order, and prefixing with numbers is a good way to get the order you want.
