locals {
  vms = {
    DE1 = [
#      {name = "open5gs-core-de", image = "Ubuntu 20.04" , flavor = "d2-4", fixed_ip_v4 = "10.30.1.10"},
      {name = "open5gs-core-de", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.10"},
#      {name = "open5gs-upf-de-1", image = "Ubuntu 20.04" , flavor = "d2-4", fixed_ip_v4 = "10.30.1.40"},
      {name = "open5gs-upf-de-1", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.40"},
      {name = "lb-de-1",  image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.11"},
      {name = "monitoring-de-1", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.12"},
      {name = "nomad-server-de-1", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.20"},
      {name = "nomad-server-de-2", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.21"},
      {name = "nomad-server-de-3", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.22"},
      {name = "nomad-client-de-1", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.1.31"},
    ],
    WAW1 = [
#      {name = "open5gs-upf-waw-1", image = "Ubuntu 20.04" , flavor = "b2-7", fixed_ip_v4 = "10.30.0.13"},
      {name = "open5gs-upf-waw-1", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.0.13"},
      {name = "nomad-client-waw-1", image_id = "" , flavor = "b2-60", fixed_ip_v4 = "10.30.0.40"},
    ],
    BHS5 = [
#      {name = "open5gs-upf-bhs-1", image = "Ubuntu 20.04" , flavor = "d2-4", fixed_ip_v4 = "10.30.4.14"},
      {name = "open5gs-upf-bhs-1", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.4.14"},
      {name = "nomad-client-bhs-1", image_id = "" , flavor = "b2-7", fixed_ip_v4 = "10.30.4.50"},
    ]
  }

  dns_records_lb = [
    {name = "grafana"},
    {name = "prom"},
    {name = "open5gs-webui"},
    {name = "nomad"},
    {name = "consul"}
  ]

  zone_id = "xxxx"

}
# open de  
# open waw 
# open bhs 
