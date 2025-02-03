#### Description

This role installs and configures Open5GS. You can choose between a full, control or user node.

#### Variables


- `open5gs_node_type` -  available options: full, control, user
- `upf_subnets` - list of subnets per upf below example
- `amf_ngap_address` - ip address on which the amf listens for ngap
- `smf_address` - ip address on which the smf listens 
- `pcf_sbi_address` - ip address on which the pcf listens
- `upf_address_gtpu` - ip address on which the upf listens for gtpu
- `upf_address_pfcp` - ip address on which the upf listens for pfcp
- `upf_pfcp_address` - ip address of pfcp interface per upf 
- `subscribers` - list of subscribers below example


#### Example

```yaml

#Full node

smf_address: 127.0.0.4
pcf_sbi_address: 127.0.0.13
upf_address_pfcp: 127.0.0.7
upf_pfcp_address:
  open5gs-core-de: 127.0.0.7
amf_ngap_address: '{{ wireguard_address }}'
upf_address_gtpu: '{{ wireguard_address }}'

subscribers:
  - imsi: 999700000000001
    dn: internet
  - imsi: 999700000000002
    dn: internet
  - imsi: 999700000000003
    dn: internet

upf_subnets:
  open5gs-core-de:
    - addr: 10.45.0.1/16
      subnet: 10.45.0.0/16
      dnn: internet
      dev: ogstun

```

```yaml
# separate control and user node

amf_ngap_address: "{{ wireguard_address }}"
smf_address: "{{ internal }}"
pcf_sbi_address: 127.0.0.13


upf_subnets:
  open5gs-upf-waw-1:
    - addr: 10.45.0.1/16
      subnet: 10.45.0.0/16
      dnn: internet-waw
      dev: ogstun
  open5gs-upf-bhs-1:
    - addr: 10.46.0.1/16
      subnet: 10.46.0.0/16
      dnn: internet-bhs
      dev: ogstun
  open5gs-upf-de-1:
    - addr: 10.47.0.1/16
      subnet: 10.47.0.0/16
      dnn: internet-de
      dev: ogstun

upf_pfcp_address:
  open5gs-upf-waw-1: 10.30.0.13
  open5gs-upf-bhs-1: 10.30.4.14
  open5gs-upf-de-1:  10.30.1.40


subscribers:
  - imsi: 999700000000001
    dn: internet-waw
  - imsi: 999700000000002
    dn: internet-waw
  - imsi: 999700000000003
    dn: internet-bhs
  - imsi: 999700000000004
    dn: internet-bhs

upf_address_gtpu: "{{ wireguard_address }}"
upf_address_pfcp: "{{ internal }}"


```

For more understanding check config templates.