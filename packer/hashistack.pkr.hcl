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
      #Grub update forces interactive that is why this seemingly crazy
      "sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -q -y -u -o Dpkg::Options::=\"--force-confdef\" --allow-downgrades --allow-remove-essential --allow-change-held-packages --allow-change-held-packages --allow-unauthenticated;",
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