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


}

provider "cloudflare" {
  api_token = "xxx"
}