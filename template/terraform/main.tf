provider "nomad" {
  address = "http://127.0.0.1:4646"
}
/*
resource "nomad_job" "your_nomad_job" {
  jobspec = file("${path.cwd}/../nomad/your_nomad_job.hcl")
  detach = false
}
*/