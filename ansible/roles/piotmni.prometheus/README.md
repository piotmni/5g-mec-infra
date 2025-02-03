#### Description

This role install prometheus. 


Configuration is created based on inventory hostname, it creates groups same as inside inventory and use hostnames created in piotmni.hosts role.


If you want add custom hosts to scrape add it in templates/prometheus.yml.


#### Variables

- `prom_version` - version of prometheus to install, default is 2.47.1
