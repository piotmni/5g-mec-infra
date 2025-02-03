resource "openstack_compute_keypair_v2" "piotr_keypair_de" {
  region     = "DE1"
  name       = "piotr_keypair_region_de"
  public_key = file("../../../ansible/files/ssh_keys/piotr.pub")
}

resource "openstack_compute_servergroup_v2" "anit-affinity-compute-group-de" {
  region   = "DE1"
  name     = "compute-group-anti-affinity-de"
  policies = ["anti-affinity"]
}

# creating instances based on local variable array
resource "openstack_compute_instance_v2" "instances_de" {
  count              = length(local.vms.DE1)
  region             = "DE1"
  name               = local.vms.DE1[count.index].name

  image_name          = try(local.vms.DE1[count.index].image, null)
  image_id            = try(local.vms.DE1[count.index].image_id, null)

  flavor_name        = local.vms.DE1[count.index].flavor
  key_pair           = openstack_compute_keypair_v2.piotr_keypair_de.id
  security_groups    = ["default"]
  stop_before_destroy = true

  scheduler_hints {
    group = openstack_compute_servergroup_v2.anit-affinity-compute-group-de.id
  }

  network {
    name = "Ext-Net"
  }

  network {
    name        = "private_network_30"
    fixed_ip_v4 = local.vms.DE1[count.index].fixed_ip_v4
  }
}


resource "cloudflare_record" "dns_records" {
  count   = length(local.dns_records_lb)
  name    = local.dns_records_lb[count.index].name
  type    = "A"
  zone_id = local.zone_id
  # 2 casue lb-1 is at third
  value   = openstack_compute_instance_v2.instances_de.2.access_ip_v4
}



output "ansible_hosts_de" {
  value = {
    for instance in openstack_compute_instance_v2.instances_de : instance.name => "ansible_host=${instance.access_ip_v4} internal=${instance.network.1.fixed_ip_v4}"
  }
}



