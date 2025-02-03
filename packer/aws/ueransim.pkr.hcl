packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

variable "aws_access_key" {
  type = string
  sensitive = true
}
variable "aws_secret_key" {
  type = string
  sensitive = true
}

source "amazon-ebs" "ueransim" {

  access_key    = var.aws_access_key
  secret_key    = var.aws_secret_key

  instance_type = "m7i.xlarge"

  ami_name     = "ueransim-docker"
  ssh_username = "ubuntu"
  region       = "us-east-1"

  source_ami = ""
#  skip_create_ami = true
#  source_ami_filter {
#    filters = {
#      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
#      root-device-type    = "ebs"
#      virtualization-type = "hvm"
#    }
#    most_recent = true
#    owners      = [""]
#  }
}

build {

  sources = [
    "source.amazon-ebs.ueransim",
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
    only = ["amazon-ebs.ueransim"]

    playbook_dir  = "../../ansible/"
    playbook_file = "../../ansible/playbooks/packer_ueransim.yml"

    role_paths        = ["../../ansible/roles"]
    galaxy_roles_path = "../../ansible/roles"

  }
  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}
