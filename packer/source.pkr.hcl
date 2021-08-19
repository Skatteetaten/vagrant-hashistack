source "vagrant" "hashistack" {
  communicator = "ssh"
  source_path = "fredrikhgrelland/bionic64-ansible-docker"
  box_version = "0.3.0"
  box_name = "hashistack"
  provider = "virtualbox"
  teardown_method = "destroy"
  output_vagrantfile = "Vagrantfile"
}