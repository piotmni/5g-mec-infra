#### Overview

Terraform is used to create servers in ovh cloud and start nomad jobs. On aws there is only one vm for test purposes.

Inside ovh-new directory there are 3 sub-dirs:
- project-setup
- full
- separated

#### Setup

- Create ovh account
- Create project
- Generate api keys
- Update vars inside project-setup/locals.tf. Api keys you can also pass as env variables(read terraform provider docs).
- Run terraform init, plan and apply inside project-setup dir.

Project setup is responsible for creating vrack network, subnets and account to access openstack. After run file named `user_credentials.rc` will be created.
Values inside this file are required to run terraform for full and separated scenario. Now before running terraform for full and separated scenario you must source this file.

```bash
source project-setup/user_credentials.rc
```

Full and separated scenario are almost the same in terraform context.

Resources created by terraform:
- ssh key - change path to your public key
- anti affinity group
- vm instances
- dns records - you can comment out this part if you don't want to create dns records

Cloudflare is used to create dns records. If you want to use it get api_key and zone_id.


In these dirs you will find `locals.tf` files that control what will be created.

Example of `locals.tf` file for separated scenario:

```hcl
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

#  dns_records_lb = [
#    {name = "grafana"},
#    {name = "prom"},
#    {name = "open5gs-webui"},
#    {name = "nomad"},
#    {name = "consul"}
#  ]
#
#  zone_id = ""

}
```

In this example there are used imaged_ids that were created with packer. You can use parameter image to start with base image. Example is commented out.

In full and separated scenario you will find `update_inventory.sh` script. This script is used to update inventory file for ansible. You can run it manually after terraform apply, it gets values from terraform output.


#### Commands

```bash
terraform init
terraform plan
terraform apply
```


