resource "nomad_job" "countdash" {
  jobspec = file("${path.cwd}/../nomad/countdash.hcl")
  detach = false
}

