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

server {
  enabled          = true
  bootstrap_expect = 3
  server_join {
    retry_join     = ["10.30.1.20", "10.30.1.21", "10.30.1.22"]
    retry_max      = 5
    retry_interval = "15s"
  }

  default_scheduler_config {
    scheduler_algorithm             = "spread"
    memory_oversubscription_enabled = true
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

ui {
  enabled = true
}
