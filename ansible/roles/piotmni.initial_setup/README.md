#### Description

This role is used at start of every playbook to initial setup server. It purpose is to setup basic things like:
- create first update and upgrade
- install basic packages like wget, curl etc. set by var `packages`
- disable swap
- install python3 and pip
- block default ubuntu user
- set vim as default edit

