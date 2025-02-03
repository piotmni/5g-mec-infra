job "core-dns-${dc}" {
  region      = "global"
  type        = "system"

  node_pool   = "${dc}"
  namespace   = "${dc}"
  datacenters = ["${dc}"]

  group "core-dns-${dc}" {

    network {
      port "dns" {
        to = 53
        static = 53
      }
    }

    service {
      name = "core-dns-${dc}"
#      check {
#        name = "alive"
#        type = "udp"
#        port = "dns"
#        interval = "10s"
#        timeout = "2s"
#      }
    }

    task "core-dns-${dc}" {
      driver = "docker"

      config {
        image = "coredns/coredns:latest"
#        network_mode = "host"
        ports = ["dns"]
        args = [
          "-conf",
          "/local/Corefile",
        ]
      }

      template {
        data = <<EOF
.:53 {
    hosts /local/dns.hosts {
        fallthrough
    }
    forward . 1.1.1.1
    errors
    health
    ready

}
EOF
        destination = "local/Corefile"
      }

      template {
        data = <<EOF
{{- $treafik_dc_ips := (key "common/treafik_dc_ips" | parseJSON) }}
{{- $traefik_ips := $treafik_dc_ips.${dc} }}
{{- range services }}
{{- range $tag := .Tags }}
{{- if $tag | regexMatch "traefik-${dc}.*=Host.*" }}
{{- if  gt (len ($tag | split "`")) 1 }}
{{-  range $ip := $traefik_ips }}
{{ $ip }} {{ index  ($tag | split "`") 1 }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
EOF
        destination = "local/dns.hosts"
      }

      resources {
        cpu    = 100
        memory = 128
      }

    }
  }
}
