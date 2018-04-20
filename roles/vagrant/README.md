# Vagrant Ansible role

Installs Vagrant and Virtualbox as the provider
Based almost entirely off https://github.com/jdauphant/ansible-role-vagrant

Is not a git submodule and doesn't auto-update

## Specify virtualbox installation (For Debian)
```
---
 - hosts: all
   roles:
    - role: vagrant
      vagrant_virtualbox_install: True
      vagrant_virtualbox_ver: "virtualbox-5.1"
