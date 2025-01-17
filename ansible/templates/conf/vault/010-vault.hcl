ui              = true
disable_mlock   = true
plugin_directory = "/etc/vault.d/plugins"

# (enp0s8 - default network)

# (docker0)
listener "tcp" {
  address       = "172.17.0.1:8200"
  tls_disable   = 1
}
# (enp0s3)
listener "tcp" {
  address       = "10.0.2.15:8200"
  tls_disable   = 1
}
# (enp0s8)
listener "tcp" {
  address       = "10.0.3.10:8200"
  tls_disable   = 1
}