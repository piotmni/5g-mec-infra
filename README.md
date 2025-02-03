### Overview

This repository contains the entire codebase required to deploy a 5G Core Network infrastructure for two different scenarios:

- Full Deployment: In this case, both the control plane and user plane components are hosted on a single server.

- Separated Deployment: Here, the control plane and user plane components are separated, and UPFs (User Plane Functions) are placed closer to the end-users.

Diagrams of both scenarios are shown at the end of README.

Additionally, the infrastructure is designed to support edge computing, allowing the deployment of applications at the network edge.


It is assumed that the user has basic knowledge of Linux, Terraform, Ansible, Vagrant, Packer and OVHCloud.


#### Repository Structure

- `ansible` - contains Ansible playbooks, roles and vars used to configure the infrastructure.
- `terraform` - contains Terraform code used to setup ovh project, create servers and start nomad jobs.
- `vagrant` - contains Vagrantfile used to spawn local UEs.
- `packer` - contains Packer code used to create images for ovh cloud - optional.

All of them contain `README.md` files with more detailed information.



#### Steps to deploy the infrastructure


The entire part related to the core of the 5g network and edge computing works in the cloud, software simulating gnb and ue is run locally. The connection between the cloud and the local environment is provided using wireguard.


1. Create an OVHCloud account and a project. And use `terraform/project-setup` to create basic tasks. 
2. Optional create images for ovh cloud using `packer` directory.
3. Create servers using `terraform/full` or `terraform/separated` directory, then use update_inventory.sh script to update inventory files.
4. Run Ansible playbooks - if you are using packer generated image you just need network and configure tag if not you must run whole playbook

```bash

# Examples
# if not used packer generated image full scenario
ansible-playbook -i inventory/full/inventory.ini playbooks/common.yml -u ubuntu

ansible-playbook -i inventory/full/inventory.ini playbooks/open5gs_full.yml
ansible-playbook -i inventory/full/inventory.ini playbooks/lb.yml
ansible-playbook -i inventory/full/inventory.ini playbooks/monitoring.yml
ansible-playbook -i inventory/full/inventory.ini playbooks/nomad-client.yml
ansible-playbook -i inventKory/full/inventory.ini playbooks/nomad-server.yml

# if used packer generated image separated scenario
ansible-playbook -i inventory/separated/inventory.ini playbooks/open5gs_separated.yml -t "network,wireguard,configure"
ansible-playbook -i inventory/separated/inventory.ini playbooks/lb.yml -t "network,configure "
ansible-playbook -i inventory/separated/inventory.ini playbooks/monitoring.yml -t "network,configure"
ansible-playbook -i inventory/separated/inventory.ini playbooks/nomad-client.yml -t "network,nomad,configure"
ansible-playbook -i inventory/separated/inventory.ini playbooks/nomad-server.yml -t "network,configure"

```
    
5. Run `wireguard_add_peers.yml` playbook to add peers to wireguard configuration. Change `wireguard_peers` variable inside `playbooks/wireguard_add_peers.yml` file to match your setup.

```bash
ansible-playbook -i inventory/full/inventory.ini playbooks/wireguard_add_peers.yml

```

6. Update local wireguard configuration(wg0 in full scenario, wg0 and wg1 in separated scenario) file and start wireguard service.
7. Update local gnb config
8. Run ue - you can spawn UEs using vagrant.


This ensures you have working setup with ue connected to core and access to internet.

#### Edge computing

Edge computing platform is based on Hashicorp Nomad and Consul. 
Additional required things are Coredns - configured so that it dynamically adds services to dns using consul-template,
directing them to Traefik - which is a reverse proxy, it automatically detects services using labels.


To better understand how it works, I suggest see the files inside `terraform/nomad-jobs` directory.

1. Add consul key (`common/treafik_dc_ips`) with ips of traefik instances ( this ips is then used inside coredns automatic generation config ) in each dc in format.
```json
{
    "de1": ["10.30.1.31"],
    "bhs5": ["10.30.4.50"],
    "waw1": ["10.30.0.40"]
}
```
3. Set env variable `NOMAD_HTTP_ADDR` to access nomad eg. `export NOMAD_ADDR=https://mgmt:mgmt@nomad.piotmni.pl` .
3. Run coredns in every dc with `terraform apply` inside `terraform/nomad-jobs/core-dns`
4. Run traefik in every dc with `terraform apply` inside `terraform/nomad-jobs/traefik`
5. To expose application see tags section inside `terraform/nomad-jobs/modules/basic-web-app/tempates/basic-web-app.hcl` directory.






### Diagrams

#### Full



![Full](./_img/full.png)


#### Separated



![Separated](./_img/separated.png)