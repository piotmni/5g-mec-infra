#### Description
This role is used to download and configure haproxy. Role is based on [ansible-haproxy](https://github.com/Oefenweb/ansible-haproxy).

#### Variables

There are a lot of variables, most important are:

- `haproxy_listen`
- `haproxy_frontend`
- `haproxy_backend`

To find variables, see defaults/main.yml file, check templates dir, see exmaple inside vars/lb.yml file or read [ansible-haproxy-vars](https://github.com/Oefenweb/ansible-haproxy)

