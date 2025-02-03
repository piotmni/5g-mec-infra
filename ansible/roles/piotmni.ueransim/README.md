#### Description

This role install ueransim based on git repo. You can use it to install gnb or ue part or full.

#### Variables

- `ueransim_node_type` - control what to install, default `full`, other options `gnb`, `ue`
- `ueransim_version` - tag of ueransim repo, default `v3.2.6`
- `amf_instance_address` - address of amf instance
- `gnb_link_ip` - configuration of gnb link ip - ipaddress for ue to connect
- `gnb_ngap_ip` - configuration of gnb ngap ip - ipaddress used to connect to amf
- `gnb_gtp_ip` - configuration of gnb link ip - ipaddress used to connect to upf
- `gnb_mcc` - mcc 
- `gnb_mnc` - mnc
- `ue_config` - dict with ue configuration, see example below

#### Example

```yaml

ue_config:
  default:
    supi: 'imsi-999700000000001'
    mcc: '999'
    mnc: '70'
    key: '465B5CE8B199B49FAA5F0A2EE238A6BC'
    op: 'E8ED289DEBA952E4283B54E88E6183CA'
    gnb_address: 127.0.0.1

    apn: 'internet'
    slice:
      sst: 1

```

Based on ue_config there is also generated gnb config - slices.

You can check config templates for better understanding.