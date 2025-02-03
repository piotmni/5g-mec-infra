datacenter = "dc1"

encrypt   = "{{ consul_encryption_key }}"
data_dir  = "{{ consul_data_dir }}"
bind_addr = "{% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"

addresses = {
  http     = "127.0.0.1 {% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"
  https    = "127.0.0.1 {% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"
  dns      = "127.0.0.1 {% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"
  grpc     = "127.0.0.1 {% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"
  grpc_tls = "127.0.0.1 {% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"
}

retry_join = ["10.30.1.20", "10.30.1.21", "10.30.1.22"]
client_addr = "127.0.0.1 {% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"

domain = "{{ consul_domain }}"

limits {
  http_max_conns_per_client = 1000
}

ui_config {
  enabled = true
}

ports {
#  dns = 8600
  dns = {{consul_dns_port}}
}

recursors = [
  "1.1.1.1",
  "8.8.8.8",
]

telemetry {
  prometheus_retention_time = "1h"
  disable_hostname          = true
}
