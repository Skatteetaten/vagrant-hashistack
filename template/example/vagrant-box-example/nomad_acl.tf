data "vault_generic_secret" "nomad_secret_id" {
  # Set count of this data source to 1 if ACLs are enabled in Nomad, and 0 if not
  count = var.nomad_acl ? 1 : 0
  path = "nomad/creds/write"
}

provider "nomad" {
  address = "http://127.0.0.1:4646"
  # Add a secret_id if ACLs are enabled in nomad
  secret_id = var.nomad_acl ? data.vault_generic_secret.nomad_secret_id[0].data.secret_id : null
}

