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

    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "4.14.0"
    }

  }
}


provider "openstack" {
  // read from env vars
#  auth_url    = var.os_auth_url
#  user_name   = var.os_user_name
#  password    = var.os_password
#  tenant_name = var.os_tenant_name
#  tenant_id   = var.os_tenant_id
#  region      = var.ovh_region


}

provider "cloudflare" {
  api_token = "xxx"
}