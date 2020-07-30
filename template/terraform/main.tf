provider "vault" {
  address = "http://127.0.0.1:8200"
  token = "master"
}

provider "nomad" {
  address = "http://127.0.0.1:4646"
  // The following line is needed if ACLs are enabled in Nomad
  //  secret_id = "${data.vault_generic_secret.nomad_secret_id.data.secret_id}"
}

// The following data-source is needed if ACLs are enabled in Nomad
/*
data "vault_generic_secret" "nomad_secret_id" {
  path = "nomad/creds/write"
}
*/


/*
resource "nomad_job" "your_nomad_job" {
  jobspec = file("${path.cwd}/../nomad/your_nomad_job.hcl")
  detach = false
}
*/
