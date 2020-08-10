build {
  sources = [
    "source.vagrant.hashistack",
  ]

  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S -E -H sh -c '{{ .Vars }} {{ .Path }}'"
    script = "install.sh"
  }

  provisioner "ansible-local" {
    playbook_dir = "../ansible/"
    playbook_file = "../ansible/install.yml"
  }

  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S -E -H sh -c '{{ .Vars }} {{ .Path }}'"
    script = "cleanup.sh"
  }
}
