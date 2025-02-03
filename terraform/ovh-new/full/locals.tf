locals {
  vms = {
    DE1 = [
      {name = "open5gs-core-de", image = "Ubuntu 20.04" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.10"},
      {name = "lb-de-1", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.11"},
      {name = "monitoring-de-1", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.12"},
#      {name = "monitoring-de-1", image = "Ubuntu 20.04" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.12"},
      {name = "nomad-server-de-1", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.20"},
      {name = "nomad-server-de-2", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.21"},
      {name = "nomad-server-de-3", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.22"},
      {name = "nomad-client-de-1", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.31"},
    ]
  }

  dns_records_lb = [
    {name = "grafana"},
    {name = "prom"},
    {name = "open5gs-webui"},
    {name = "nomad"},
    {name = "consul"}

  ]

  zone_id = "xxx"

}


