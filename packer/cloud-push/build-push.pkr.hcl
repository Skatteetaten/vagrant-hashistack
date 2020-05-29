build {
  sources = [
    "source.vagrant.hashistack",
  ]

  provisioner "shell" {
    script = "bootstrap.sh"
  }

  provisioner "ansible-local" {
    name = "ansible"
    playbook_dir = "../ansible"
    playbook_file = "../ansible/playbook.yml"
  }

  post-processor "vagrant-cloud" {
    box_tag = "fredrikhgrelland/hashistack"
    version = "${var.version}"
  }
}
