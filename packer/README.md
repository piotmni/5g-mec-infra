#### Overview

Packer is not required. It is used to create preconfigured images so start process is faster.
Before using you must set up ovh project with terraform, so you have credentials and network ids.

Images are created per dc.

#### Usage

Before using setup up files with vars:
- common.pkrvars.hcl
- bhs5.pkvars.hcl
- de1.pkvars.hcl
- waw1.pkvars.hcl


```bash

# 3 dc because the same image can be used in different dc as upf/core
packer build  -var-file=common.pkrvars.hcl -var-file=bhs5.pkvars.hcl packer-open5gs.pkr.hcl
packer build  -var-file=common.pkrvars.hcl -var-file=de1.pkvars.hcl packer-open5gs.pkr.hcl
packer build  -var-file=common.pkrvars.hcl -var-file=waw1.pkvars.hcl packer-open5gs.pkr.hcl

# image specified in this file is used only inside de1
packer build -var-file=common.pkrvars.hcl -var-file=de1.pkvars.hcl packer-de1.pkr.hcl
# you can specify only 
packer build -only="openstack.monitoring" -var-file=common.pkrvars.hcl -var-file=de1.pkvars.hcl packer-de1.pkr.hcl

# same as with open5gs image
packer build  -var-file=common.pkrvars.hcl -var-file=bhs5.pkvars.hcl packer-nomad-client.pkr.hcl
packer build  -var-file=common.pkrvars.hcl -var-file=waw1.pkvars.hcl packer-nomad-client.pkr.hcl
packer build  -var-file=common.pkrvars.hcl -var-file=de1.pkvars.hcl packer-nomad-client.pkr.hcl
```