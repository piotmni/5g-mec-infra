variable "OS_AUTH_URL" {
  type      = string
  sensitive = true
}

variable "OS_PASSWORD" {
  type      = string
  sensitive = true
}
variable "OS_REGION_NAME" {
  type      = string
  sensitive = true
}
variable "OS_TENANT_NAME" {
  type      = string
  sensitive = true
}

variable "OS_USERNAME" {
  type      = string
  sensitive = true
}

variable "OS_TENANT_ID" {
  type      = string
  sensitive = true
}

variable "network_id" {
  type = string
}

variable "dc_name" {
  type = string
}

packer {
  required_plugins {
    openstack = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/openstack"
    }
  }
}

source "openstack" "nomad-client" {
  identity_endpoint = var.OS_AUTH_URL
  password          = var.OS_PASSWORD
  region            = var.OS_REGION_NAME
  tenant_name       = var.OS_TENANT_NAME
  tenant_id         = var.OS_TENANT_ID
  username          = var.OS_USERNAME
  domain_name       = "default"

  flavor         = "b2-7"
  image_min_disk = 20

  image_name        = "nomad-client"
  source_image_name = "Ubuntu 20.04"

  ssh_username           = "ubuntu"
  ssh_ip_version         = 4
  ssh_handshake_attempts = 20

  networks = [var.network_id]
}


build {
  sources = [
    "source.openstack.nomad-client",
  ]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y software-properties-common",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt-get install -y ansible"
    ]
  }

  provisioner "ansible-local" {
    only = ["openstack.nomad-client"]

    playbook_dir  = "../../ansible/"
    playbook_file = "../../ansible/playbooks/packer_nomad_client.yml"

    role_paths        = ["../../ansible/roles"]
    galaxy_roles_path = "../../ansible/roles"

    extra_arguments = [
      "--extra-vars",
      "ovh_region=\"${var.dc_name}\""
    ]
  }


  post-processor "manifest" {
    output      = "manifest.json"
    strip_path  = true
    custom_data = {
      region = var.OS_REGION_NAME
    }
  }

  post-processor "shell-local" {
    inline = [
      "mkdir -p images/",
      "REGION=$(jq -r \"[.builds[] | select(.name==\\\"$PACKER_BUILD_NAME\\\")] | last | .custom_data.region\" manifest.json)",
      "jq -r \"[.builds[] | select(.name==\\\"$PACKER_BUILD_NAME\\\")] | last | .artifact_id\" manifest.json > images/$PACKER_BUILD_NAME-$REGION.txt"
    ]
  }
}
