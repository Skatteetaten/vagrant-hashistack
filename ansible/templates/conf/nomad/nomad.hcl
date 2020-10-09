consul {
    token = "master"
    address = "127.0.0.1:8500"
}

advertise {
    http = "{{ GetInterfaceIP \"eth1\" }}"
    rpc  = "{{ GetInterfaceIP \"eth1\" }}"
    serf  = "{{ GetInterfaceIP \"eth1\" }}"
}

bind_addr = "0.0.0.0"

vault {
  enabled = true
  token = "master"
  address = "http://127.0.0.1:8200"
}

client {
    enabled = true
    network_interface = "eth1"
}