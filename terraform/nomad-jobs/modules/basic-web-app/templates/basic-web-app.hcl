job "basic-web-app-${dc}" {
  node_pool   = "${dc}"
  namespace   = "${dc}"
  datacenters = ["${dc}"]
  type        = "service"

  group "basic-web-app" {
    count = 1

    network {
      port "http" {
        to = 8080
      }
    }

    task "basic-web-app" {
      driver = "docker"

      config {
        image = "docker.io/piotmni/golang-basic-web-app:1.0.0"
        ports = ["http"]
      }

      service {
        name = "basic-web-app-${dc}"
        port = "http"
        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
        tags = [
        "traefik-${dc}.http.routers.basic-web-app.rule=Host(`basic-web-app.piotmni.pl`)",
        "traefik-${dc}.http.routers.basic-web-app.tls=true",
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
