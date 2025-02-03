#### Description

This role create users with ssh keys and sudo rights. It also setup custom ansible facts script to get name of network interfaces required for other roles like firewall or netwokring.
Another task is to set hostname.



[//]: # (set_hostname: yes)

[//]: # (skip_cloudinit_disable: no)

[//]: # (hostname_domain: "internal.piotmni.pl")
Available vars: 
- `hostname_domain` - domain name to set as hostname - hostname will be set to `{{ inventory_hostname }}.{{ hostname_domain }}`
- `set_hostname` - set hostname or not
- `skip_cloudinit_disable` - skip disabling cloud-init or not
- `common_users` - list of users to create

Format of `common_users`:
```yaml
common_users:
  - name: piotr
    authorized_key: "{{ lookup('file', '../files/ssh_keys/piotr.pub')}}"
    groups: [sudo, wheel]
    password: '{{ password_piotr }}'
    update_password: on_create
    basic_auth: yes
```


