#### Overview

Vagrant file is configured to use a servers.yml as source of information about servers to be created. 
Every server is meant to be an ue.
Inside vagrantfile i take vars from servers.yml format it and pass it to ansible playbook.


example of servers.yml:
```yaml
- name: ue1
  memory: 2048
  cpus: 4
  imsi: 999700000000001
  dnn: internet-waw
  gnb_address: 192.168.1.48
  dns_address: 10.30.0.40
  upf_subnet: 10.45.0.0/16
```

#### Usage

Start 
```bash
vagrant up
```

Run just provision

```bash
vagrant up --provision
```

Stop

```bash
vagrant halt
```

Destroy

```bash
vagrant destroy
```

Connect to vm 
    
```bash
vagrant ssh <name>
```