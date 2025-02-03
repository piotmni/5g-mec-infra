job "test-nginx-job-${dc}" {
  node_pool   = "${dc}"
  namespace   = "${dc}"
  datacenters = ["${dc}"]
  type        = "service"

  group "nginx-group" {
    count = 1

    network {
      port "http" {
        to = 80
      }
    }

    task "nginx" {
      driver = "docker"

      config {
        image = "nginx:latest"
        ports = ["http"]
      }

      service {
        name = "nginx-for-traefik"
        port = "http"
        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
        tags = [
        "traefik-${dc}.http.routers.test-nginx.rule=Host(`test-nginx.piotmni.pl`)",
        "traefik-${dc}.http.routers.test-nginx.tls=true",
        "traefik-${dc}.enable=true"
        ]
      }

#      service {
#        name = "test-nginx"
#        port = "http"
#        address = "10.30.1.31"
#      }

    }
  }
}
