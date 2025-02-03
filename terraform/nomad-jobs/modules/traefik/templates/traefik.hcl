job "traefik-${dc}" {
  region      = "global"
  type        = "system"


  node_pool   = "${dc}"
  namespace   = "${dc}"
  datacenters = ["${dc}"]

  group "traefik-${dc}" {

    network {

      port "http" {
        static = 80
      }

      port "https" {
        static = 443
      }

      port "dashbaord" {
        static = 8081
      }

    }

    service {
      name = "traefik-${dc}"
      check {
        name = "alive"
        type = "tcp"
        port = "http"
        interval = "10s"
        timeout = "2s"
      }
    }

    task "traefik-${dc}" {
      driver = "docker"

      config {
        image = "traefik:2.10.4"
        network_mode = "host"
        ports = ["http", "https", "dashbaord"]
        volumes = [
          "local/traefik.toml:/etc/traefik/traefik.toml",
        ]
      }

      template {
        data = <<EOF

[providers.file]
  filename = "/local/traefik-certs.toml"

[entryPoints.web]
  address = ":80"

  [entryPoints.web.http]
    [entryPoints.web.http.redirections]
      [entryPoints.web.http.redirections.entryPoint]
        to = "websecure"
        scheme = "https"

[entryPoints.websecure]
  address = ":443"

[entryPoints.traefik]
  address = ":8081"

[api]
  dashboard = true
  insecure  = true


[providers.consulCatalog]
  prefix = "traefik-${dc}"
  exposedByDefault = false

  [providers.consulCatalog.endpoint]
    address = "{{ env "CONSUL_HTTP_ADDR" }}"

EOF
        destination = "local/traefik.toml"
      }

      template {
        data = <<EOF
[tls]
  [[tls.certificates]]
    certFile = "/local/piotmni.pl.crt"
    keyFile = "/local/piotmni.pl.key"

[tls.stores]
    [tls.stores.default]
      [tls.stores.default.defaultCertificate]
        certFile = "/local/piotmni.pl.crt"
        keyFile = "/local/piotmni.pl.key"

EOF
        destination = "local/traefik-certs.toml"
      }

      template {
        data = <<EOF
paste cert or use hashicorp vault to store it
EOF
        destination = "local/piotmni.pl.crt"
      }

      template {
        data = <<EOF
paste key or use hashicorp vault to store it
EOF
        destination = "local/piotmni.pl.key"
      }

      resources {
        cpu    = 100
        memory = 128
      }

    }
  }
}
