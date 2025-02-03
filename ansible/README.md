#### Overview

This directory contains ansible code used to configure the infrastructure.

Directory structure:
- files - it contains static files that I thought should be global in the Ansible context like ssh key
- inventory - it contains inventory files for ansible with group/host vars
- playbooks - it contains playbooks that are used to configure the infrastructure
- roles - it contains roles that are used by playbooks most of them have `README.md` file inside
- vars - it contains vars used by playbooks

#### Setup 

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

#### Example usage

```bash
ansible-playbook -i inventory/full/inventory.ini playbooks/common.yml -l open5gs -u ubuntu
ansible-playbook -i inventory/separated/inventory.ini playbooks/open5gs_separated.yml -t "network,wireguard,configure"
ansible-playbook -i inventory/separated/inventory.ini playbooks/lb.yml -t "network,configure "
```


Typical first step with new server is to run common playbook that creates users. 