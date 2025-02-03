#### Description

This role install telegraf, software used to collect metrics from system and send then output them in prometheus format so prometheus server can scrape it.


#### Variables

Role was created mainly for this project, so there are no many variables to configure. If you want to change something, you can do it in templates/telegraf.conf.j2 file.

One required variable is 
- `prometheus_exporter_password_plain` - password for prometheus_exporter user. It is used to authenticate prometheus server to telegraf.

You can find some variables inside defaults/main.yml.


File templates/telegraf.conf.j2 contains three sections:
- `agent` - contains setting like hostname, interval etc.
- `output` - contains configuration for prometheus output
- `intpus` - contains configuration for inputs which then collect metrics from system, there are some always enabled inputs like cpu, mem and some inputs that are configured based on installed package (like docker) or based on group from inventory (scraping metrics from open5gs and haproxy).





