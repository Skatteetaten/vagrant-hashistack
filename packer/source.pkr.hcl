source "vagrant" "hashistack" {
  communicator = "ssh"
  source_path = "ubuntu/hirsute64"
  box_version = "20210818.0.0"
  box_name = "hashistack"
  provider = "virtualbox"
  teardown_method = "destroy"
  output_vagrantfile = "Vagrantfile"
}