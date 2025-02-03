#### Description

This role is used to configure firewall on Ubuntu. It uses variables to configure ufw and iptables.

#### Variables
- `ufw_default_incoming_policy` - default deny
- `ufw_default_outgoing_policy` - default allow
- `ufw_dependencies` - list of packages to install requried for ufw, default: `['ufw', 'iproute2', 'procps']`
- `firewall_ports` - list of ports to open with ufw, default: `[]`, allowed field can be found inside configure_ufw
- `firewall_route_ports` - list with configuration of allowed routing between interfaces, default: `[]`
- `iptables_filter_rules` - list with configuration of iptables filter rules, default: `[]`, allowed field can be found inside iptables_rules_for_ufw
- `iptables_nat_rules` - list with configuration of iptables nat rules, default: `[]`, allowed field can be found inside iptables_rules_for_ufw


#### Examples

```yaml

firewall_ports:
  - { to_port: 80, zone: public }
  - { to_port: 80, zone: home }
  - { to_port: 443, zone: public }
  - { to_port: 443, zone: home }
  - { to_port: 1081, zone: home } # telegraf
  - { interface: docker0 }

firewall_route_ports:
  - { interface_in: "ogstun", interface_out: "{{ ansible_local.network_interfaces.public_interface }}" }
  - { interface_in: "ogstun", interface_out: "{{ ansible_local.network_interfaces.private_interface }}" }


iptables_filter_rules:
  - {port: 38412, action: 'ACCEPT', protocol: 'sctp', interface: 'wg0', chain: 'INPUT' }

iptables_nat_rules:
  - {chain: 'POSTROUTING', action: 'MASQUERADE', source_addr: '10.45.0.0/16', out_interface: 'ogstun',  negate_out_interface: true}


```