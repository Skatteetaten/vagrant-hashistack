job "nginx"{
  datacenters = ["dc1"]
  group "server" {
    service {
      name = "nginx"
    }
    task "web" {
      driver = "docker"
      config {
        image = "nginx:latest"
      }
    }
  }
}