advertise {
    http = "{{ GetInterfaceIP \"eth1\" }}"
    rpc  = "{{ GetInterfaceIP \"eth1\" }}"
    serf  = "{{ GetInterfaceIP \"eth1\" }}"
}

bind_addr = "0.0.0.0"

client {
    enabled = true
    network_interface = "eth1"
}