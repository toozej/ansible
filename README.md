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

