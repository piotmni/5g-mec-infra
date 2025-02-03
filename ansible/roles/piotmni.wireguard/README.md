#### Description

This role install wireguard and create base config without peers.
Role install wireguard, generate keys and create config.


#### Variables

- `wireguard_interface` - name of wireguard interface, default wg0
- `wireguard_port` - port for wireguard, default 51820
- `wireguard_mtu` - mtu for wireguard interface, default 1420
- `wg_postup_router_ubuntu` - iptables rule to be executed after wg interface is up, default `iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o {{ ansible_local.network_interfaces.private_interface }} -j MASQUERADE`
- `wg_postdown_router_ubuntu` - iptables rule to be executed after wg interface is down, default `iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o {{ ansible_local.network_interfaces.private_interface }} -j MASQUERADE`