terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.51.1"
    }

    ovh = {
      source  = "ovh/ovh"
      version = "0.30.0"
    }
  }
}

provider "ovh" {
  endpoint           = "ovh-eu"
  application_key    = local.ovh_application_key
  application_secret = local.ovh_application_secret
  consumer_key       = local.ovh_consumer_key
}



#provider "openstack" {
#  auth_url    = ovh_cloud_project_user.terraform.openstack_rc.OS_AUTH_URL
#  user_name   = ovh_cloud_project_user.terraform.username
#  password    = ovh_cloud_project_user.terraform.password
#  tenant_name = ovh_cloud_project_user.terraform.openstack_rc.OS_TENANT_NAME
#  tenant_id   = ovh_cloud_project_user.terraform.openstack_rc.OS_TENANT_ID
#  domain_name = "default"
#}
