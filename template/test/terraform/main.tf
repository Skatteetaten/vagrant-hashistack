provider "nomad" {
  address = "http://127.0.0.1:4646"
}

resource "nomad_job" "countdash" {
  jobspec = file("${path.cwd}/../nomad/countdash.hcl")
  detach = false
}