#### Description

This module do basic setup of project on OVH. It is base for other modules.
It creates network and openstack user to be used by other modules.

#### Requirements

OVH credentials from api https://eu.api.ovh.com/createToken/

Genearate with full permissions 
- GET /*
- POST /*
- PUT /*
- DELETE /*

And you get
- ovh_application_secret
- ovh_consumer_key
- ovh_application_key

This parameters should be taken from UI
- ovh_project_id
- vrack_id

Set it to locals file
