source "vagrant" "hashistack" {
  communicator = "ssh"
  source_path = "hashicorp/bionic64"
  box_version = "1.0.282"
  box_name = "hashistack"
  provider = "virtualbox"
  add_cacert = "/etc/ssl/certs/ca-certificates.crt"
}

build {
  sources = [
    "source.vagrant.hashistack",
  ]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      #"DEBIAN_FRONTEND=noninteractive sudo apt-get -y -o Dpkg::Options::=\"--force-confdef\" -o Dpkg::Options::=\"--force-confold\" upgrade",
      "sudo apt-get install python3-distutils -y && curl -k -s https://bootstrap.pypa.io/get-pip.py | sudo python3",
      "sudo pip install ansible"
    ]
  }

  provisioner "ansible-local" {
    playbook_dir = "../ansible"
    playbook_file = "../ansible/playbook.yml"
  }

  post-processor "vagrant-cloud" {
    box_tag = "fredrikhgrelland/hashistack"
    version = "${var.version}"
    #access_token = "${{var.cloud_token}}"
  }
}