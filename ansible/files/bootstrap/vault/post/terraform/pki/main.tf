# https://registry.terraform.io/providers/hashicorp/vault/latest/docs
provider "vault" {
  # Using variables from ansible env
}

#
# Create a Self Signed Certificate , to use as the Root Certificate Authority
#
resource "vault_mount" "pki" {
  path        = "pki"
  type        = "pki"
  description = "Vault's PKI backend"
  default_lease_ttl_seconds = 86400
  max_lease_ttl_seconds = 2592000
}

resource "vault_pki_secret_backend_root_cert" "root" {
  depends_on = [ vault_mount.pki ]

  backend = vault_mount.pki.path

  type = "internal"
  common_name = "Root CA"
  ttl = "315360000"
}

resource "vault_pki_secret_backend_config_urls" "config_urls" {
  depends_on              = [ vault_pki_secret_backend_root_cert.root ]
  backend                 = vault_mount.pki.path
  issuing_certificates    = ["http://127.0.0.1:8200/v1/pki/ca"]
  crl_distribution_points = ["http://127.0.0.1:8200/v1/pki/crl"]
}

resource "vault_pki_secret_backend_role" "role" {
  depends_on  = [ vault_pki_secret_backend_root_cert.root ]
  backend     = vault_mount.pki.path
  name        = "default"
  allow_localhost = true
  allow_any_name = true
  enforce_hostnames = false
}
terraform {
  required_providers {
    vault = {
      version = ">2.0.0"
    }
  }
}
