advertise {
    http = "{{ GetInterfaceIP \"enp0s8\" }}"
    rpc  = "{{ GetInterfaceIP \"enp0s8\" }}"
    serf  = "{{ GetInterfaceIP \"enp0s8\" }}"
}

bind_addr = "0.0.0.0"

client {
    enabled = true
    network_interface = "enp0s8"
}