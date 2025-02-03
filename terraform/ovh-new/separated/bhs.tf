resource "openstack_compute_keypair_v2" "piotr_keypair_bhs" {
  region     = "BHS5"
  name       = "piotr_keypair_region_bhs"
  public_key = file("../../../ansible/files/ssh_keys/piotr.pub")
}

resource "openstack_compute_servergroup_v2" "anit-affinity-compute-group-bhs" {
  region   = "BHS5"
  name     = "compute-group-anti-affinity-bhs"
  policies = ["anti-affinity"]
}

# creating instances based on local variable array
resource "openstack_compute_instance_v2" "instances_bhs" {
  count               = length(local.vms.BHS5)
  region              = "BHS5"
  name                = local.vms.BHS5[count.index].name

  image_name          = try(local.vms.BHS5[count.index].image, null)
  image_id            = try(local.vms.BHS5[count.index].image_id, null)


  flavor_name         = local.vms.BHS5[count.index].flavor
  key_pair            = openstack_compute_keypair_v2.piotr_keypair_bhs.id
  security_groups     = ["default"]
  stop_before_destroy = true

  scheduler_hints {
    group = openstack_compute_servergroup_v2.anit-affinity-compute-group-bhs.id
  }

  network {
    name = "Ext-Net"
  }

  network {
    name        = "private_network_30"
    fixed_ip_v4 = local.vms.BHS5[count.index].fixed_ip_v4
  }
}

output "ansible_hosts_bhs" {
  value = {
    for instance in openstack_compute_instance_v2.instances_bhs : instance.name =>
    "ansible_host=${instance.access_ip_v4} internal=${instance.network.1.fixed_ip_v4}"
  }
}



