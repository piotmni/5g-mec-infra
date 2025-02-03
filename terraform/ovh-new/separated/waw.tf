resource "openstack_compute_keypair_v2" "piotr_keypair_waw" {
  region     = "WAW1"
  name       = "piotr_keypair_region_waw"
  public_key = file("../../../ansible/files/ssh_keys/piotr.pub")
}

resource "openstack_compute_servergroup_v2" "anit-affinity-compute-group-waw" {
  region   = "WAW1"
  name     = "compute-group-anti-affinity-waw"
  policies = ["anti-affinity"]
}

# creating instances based on local variable array
resource "openstack_compute_instance_v2" "instances_waw" {
  count               = length(local.vms.WAW1)
  region              = "WAW1"
  name                = local.vms.WAW1[count.index].name

  image_name          = try(local.vms.WAW1[count.index].image, null)
  image_id            = try(local.vms.WAW1[count.index].image_id, null)

  flavor_name         = local.vms.WAW1[count.index].flavor
  key_pair            = openstack_compute_keypair_v2.piotr_keypair_waw.id
  security_groups     = ["default"]
  stop_before_destroy = true

  scheduler_hints {
    group = openstack_compute_servergroup_v2.anit-affinity-compute-group-waw.id
  }

  network {
    name = "Ext-Net"
  }

  network {
    name        = "private_network_30"
    fixed_ip_v4 = local.vms.WAW1[count.index].fixed_ip_v4
  }
}

output "ansible_hosts_waw" {
  value = {
    for instance in openstack_compute_instance_v2.instances_waw : instance.name =>
    "ansible_host=${instance.access_ip_v4} internal=${instance.network.1.fixed_ip_v4}"
  }
}



