# Home Ansible Setup

[![Build Status](https://travis-ci.org/toozej/ansible.svg?branch=master)](https://travis-ci.org/toozej/ansible)

## What is it
Ansible is a fantastic configuration management system that I use to self-provision servers & VMs. 
Currently I have Ansible run itself locally on a server during provisioning/bootstrapping only, but
I have plans to also have Ansible update itself (by pulling this repo) and 
running against localhost periodically using Cron.

## How to use it
- scp private SSH key into ~/.ssh/
- curl https://raw.githubusercontent.com/toozej/ansible/master/bootstrap.sh -O && chmod +x bootstrap.sh
- check the playbook: sudo ./bootstrap.sh -c $playbook\_name.yml
- run the playbook: sudo ./bootstrap.sh -r $playbook\_name.yml

Or if you would rather just run one playbook stand-alone:
- cd /tmp/ansible; ansible-playbook $playbook\_name.yml

Or if you want to run a playbook stand-alone skipping tags:
- cd /tmp/ansible; ansible-playbook $playbook\_name.yml --skip-tags $tag\_name,$tag\_name2

## Useful info for developing Ansible
[Ansible Porting Guides](https://github.com/ansible/ansible/tree/devel/docs/docsite/rst/porting_guides)

### Setting up Pre-commit hooks
From the root of this repo, run the following commands:
- `sudo pip install pre-commit`
- `pre-commit install`
- `pre-commit autoupdate`
- commit any changes made, and ensure that pre-commit functions as expected
- push like usual

## Overview of parts of this repo
(Note below might be out of date, as it's a pain to keep up with the README while developing this repo)

### bootstrap.sh
- determine OS type: RHEL, Debian, CoreOS, other
- run pkg manager
    - update
	- if RHEL, install EPEL repo
    - install -y ansible git python2.7
- pull down Ansible playbooks, roles from git
- install and run playbooks commond on which type the system is

### Playbooks
- common
    - common role only
- server (VM)
    - file server, VM, common, docker
    - db server: above + db
    - web server: above + web
- desktop (VM or BM)
    - home: chrome, audio, GUI, office, common
    - dev: chrome, GUI, common, db, docker, dev-python, dev-ruby, dev-go, dev-base
    - ops: chrome, GUI, common, docker, k8s, dev-base
    - all

