#resource "ovh_vrack_cloudproject" "vcp" {
#  service_name = local.vrack_id
#  project_id   = local.ovh_project_id
#}

# GRA - Gravelines - france
# BHS - Beauharnois - canada
resource "ovh_cloud_project_network_private" "network" {
  service_name = local.ovh_project_id
  name         = "private_network_30"
  regions      = ["WAW1", "DE1", "UK1", "GRA7", "BHS5"]
  vlan_id      = 30
}

resource "ovh_cloud_project_network_private_subnet" "subnet_waw" {
  service_name = local.ovh_project_id
  network_id   = ovh_cloud_project_network_private.network.id
  start        = "10.30.0.2"
  end          = "10.30.0.254"
  network      = "10.30.0.0/16"
  dhcp         = true
  region       = "WAW1"
  no_gateway   = true
}

resource "ovh_cloud_project_network_private_subnet" "subnet_de" {
  service_name = local.ovh_project_id
  network_id   = ovh_cloud_project_network_private.network.id
  start        = "10.30.1.2"
  end          = "10.30.1.254"
  network      = "10.30.0.0/16"
  dhcp         = true
  region       = "DE1"
  no_gateway   = true
}

resource "ovh_cloud_project_network_private_subnet" "subnet_gra" {
  service_name = local.ovh_project_id
  network_id   = ovh_cloud_project_network_private.network.id
  start        = "10.30.2.2"
  end          = "10.30.2.254"
  network      = "10.30.0.0/16"
  dhcp         = true
  region       = "GRA7"
  no_gateway   = true
}

resource "ovh_cloud_project_network_private_subnet" "subnet_uk" {
  service_name = local.ovh_project_id
  network_id   = ovh_cloud_project_network_private.network.id
  start        = "10.30.3.2"
  end          = "10.30.3.254"
  network      = "10.30.0.0/16"
  dhcp         = true
  region       = "UK1"
  no_gateway   = true
}

resource "ovh_cloud_project_network_private_subnet" "subnet_bhs" {
  service_name = local.ovh_project_id
  network_id   = ovh_cloud_project_network_private.network.id
  start        = "10.30.4.2"
  end          = "10.30.4.254"
  network      = "10.30.0.0/16"
  dhcp         = true
  region       = "BHS5"
  no_gateway   = true
}

resource "ovh_cloud_project_user" "terraform" {
  service_name = local.ovh_project_id
  description  = "terraform"
  role_names   = [
    "administrator",
    "authentication",
    "backup_operator",
    "compute_operator",
    "image_operator",
    "infrastructure_supervisor",
    "network_operator",
    "network_security_operator",
    "objectstore_operator",
    "volume_operator",
  ]
}

resource "null_resource" "save_user_credentials" {
  depends_on = [ovh_cloud_project_user.terraform]

  provisioner "local-exec" {
    command = <<EOT
      echo 'export OS_IDENTITY_API_VERSION=3' >> user_credentials.rc
      echo 'export OS_AUTH_URL=${ovh_cloud_project_user.terraform.openstack_rc.OS_AUTH_URL}' >> user_credentials.rc
      echo 'export OS_USERNAME=${ovh_cloud_project_user.terraform.username}' >> user_credentials.rc
      echo 'export OS_PASSWORD=${ovh_cloud_project_user.terraform.password}' >> user_credentials.rc
      echo 'export OS_TENANT_NAME=${ovh_cloud_project_user.terraform.openstack_rc.OS_TENANT_NAME}' >> user_credentials.rc
      echo 'export OS_TENANT_ID=${ovh_cloud_project_user.terraform.openstack_rc.OS_TENANT_ID}' >> user_credentials.rc
    EOT
  }
}