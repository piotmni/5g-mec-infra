#### Description

This role is used to configure network interfaces on Ubuntu.
Main tasks are:
- set ip forwading
- set private address for interface
- setup contrack if configured

#### Variables

- `network_enable_ip_forwarding` - boolean, default: `false` 
- `network_mask` - integer, default: `23`
- `netplan_config_path` - path to netplan config file, default: `/etc/netplan/50-cloud-init.yaml`
- `internal` - ip address of internal interface, no default mainly set inside inventory
- `conntrack_max` - value set for conntrack max, no default
- `conntrack_hash_table_size` - value set for conntrack hash table size, no default

