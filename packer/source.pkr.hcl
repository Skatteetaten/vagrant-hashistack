source "vagrant" "hashistack" {
  communicator = "ssh"
  source_path = "hashicorp/bionic64"
  box_version = "1.0.282"
  box_name = "hashistack"
  provider = "virtualbox"
  teardown_method = "destroy"
  output_vagrantfile = "Vagrantfile"
}