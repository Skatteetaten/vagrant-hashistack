primary_datacenter = "dc1"

bind_addr = "{{ GetInterfaceIP \"docker0\" }}"
client_addr = "{{ GetInterfaceIP \"docker0\" }}"

ports = {
  dns = 53
  grpc = 8502
}

addresses {
  dns = "127.0.0.1 {{ GetInterfaceIP \"docker0\" }} {{ GetInterfaceIP \"enp0s3\" }} {{ GetInterfaceIP \"enp0s8\" }}"
  grpc = "127.0.0.1 {{ GetInterfaceIP \"docker0\" }} {{ GetInterfaceIP \"enp0s3\" }} {{ GetInterfaceIP \"enp0s8\" }}"
  http = "127.0.0.1 {{ GetInterfaceIP \"docker0\" }} {{ GetInterfaceIP \"enp0s3\" }} {{ GetInterfaceIP \"enp0s8\" }}"
}
