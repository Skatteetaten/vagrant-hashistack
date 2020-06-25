build {
  sources = [
    "source.vagrant.hashistack",
  ]

  provisioner "shell" {
    script = "bootstrap.sh"
  }

  provisioner "ansible-local" {
    playbook_dir = "../ansible/"
    playbook_file = "../ansible/bootstrap.yml"
  }
}
