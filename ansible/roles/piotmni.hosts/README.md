#### Description

This role ensure there is access to other internal servers through domain name. Role loop over all hosts in inventory file and setup line `{{ inventory_hostname }}.{{ hosts_internal_domain }} {{ internal}}` 


#### Variables
- `hosts_internal_domain` - internal domain name, default: `internal.piotmni.pl`
- `network_generate_hosts_enabled` - enable/disable generation, default: `yes`
