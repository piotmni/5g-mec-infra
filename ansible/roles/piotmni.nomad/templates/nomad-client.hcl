datacenter = "{{ dc }}"
bind_addr  = "127.0.0.1"
data_dir   = "{{ nomad_data_dir }}"
log_level  = "INFO"

advertise {
  http = "{% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"
  rpc  = "{% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"
  serf = "{% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"
}

addresses {
  http = "127.0.0.1 {% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"
  rpc  = "{% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"
  serf = "{% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"address\" }}{% endraw %}"
}

consul {
  address = "127.0.0.1:8500"
}

client {

  // {% if nomad_client_node_pool is defined  %}

  node_pool = "{{ nomad_client_node_pool }}"

  // {% endif %}

  enabled           = true
  servers     = ["10.30.1.20", "10.30.1.21", "10.30.1.22"]
  network_interface = "{% raw %}{{ GetPrivateInterfaces | exclude \"type\" \"IPv6\" | attr \"name\"}}{% endraw %}"
}

plugin "docker" {
  config {
    volumes {
      enabled = false
    }
  }
}

limits {
  http_max_conns_per_client = 1024
}

telemetry {
  collection_interval        = "15s"
  disable_hostname           = true
  prometheus_metrics         = true
  publish_allocation_metrics = true
  publish_node_metrics       = true
}
