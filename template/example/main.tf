resource "nomad_job" "countdash" {
  jobspec = file("${path.module}/nomad/countdash.hcl")
  detach = false
}