# Home Ansible Setup
[![CI](https://github.com/toozej/ansible/workflows/CI/badge.svg?event=push)](https://github.com/toozej/ansible/actions?query=workflow%3ACI)

## What is it
Ansible is a fantastic configuration management system that I use to self-provision servers & VMs. 
Currently I have Ansible run itself locally on a server during provisioning/bootstrapping only, but
I have plans to also have Ansible update itself (by pulling this repo) and 
running against localhost periodically using Cron.

## Supported versions

Use Python 3.11 or later with a compatible Ansible release. The minimum
ansible-core version is 2.19.11, which Debian 13 provides. CI checks Python
3.11–3.14 with ansible-core 2.19–2.21, subject to upstream Python support.
Ansible 2.19 supports Python 3.11–3.13. Ansible 2.20 and 2.21 support
Python 3.12–3.14. These releases do not support Python 3.15.

For a Python installation, use a virtual environment:

```sh
python3 -m venv .venv
. .venv/bin/activate
python -m pip install -r requirements-lint.txt
ansible-galaxy collection install -r requirements.yml
```

The distribution `ansible` package also provides the required collections on
Debian 13. The bootstrap script installs the declared collections.
See [validation instructions](tests/README.md) for container checks and
version sources. CI does not provision the runner host.

## How to use it
- scp private SSH key into ~/.ssh/
- grab bootstrap.sh
```bash
curl https://raw.githubusercontent.com/toozej/ansible/main/bootstrap.sh -O && chmod +x bootstrap.sh
```
- check the playbook: sudo ./bootstrap.sh -c $playbook\_name.yml
- run the playbook: sudo ./bootstrap.sh -r $playbook\_name.yml

Or if you would rather just automatically run the common playbook as a minimal install:
```bash
curl https://raw.githubusercontent.com/toozej/ansible/main/minimal.sh -O && chmod +x minimal.sh && ./minimal.sh
```

Or if you would rather just run one playbook stand-alone:
- cd /tmp/ansible; ansible-playbook $playbook\_name.yml

Or if you want to run a playbook stand-alone skipping tags:
- cd /tmp/ansible; ansible-playbook $playbook\_name.yml --skip-tags $tag\_name,$tag\_name2

Or if you want to run a playbook straight from the repo directory:
- `sudo ANSIBLE_ROLES_PATH=/home/james/src/github/toozej/ansible/roles ansible-playbook playbooks/simplenote-only.yml`

## Useful info for developing Ansible
- get localhost facts:
    `sudo ansible localhost -m setup`
[Ansible Porting Guides](https://github.com/ansible/ansible/tree/devel/docs/docsite/rst/porting_guides)
- validate Jenkinsfile using:
    `curl --user username:password -X POST -F "jenkinsfile=<Jenkinsfile" https://jenkins.example.com/pipeline-model-converter/validate` 
- GitHub Actions CI workflow based heavily off https://github.com/geerlingguy/ansible-role-firewall/blob/master/.github/workflows/ci.yml
    - OS Distrubtion matrix from https://github.community/t/create-matrix-with-multiple-os-and-env-for-each-one/16895/6

### Setting up Pre-commit hooks
From the root of this repo, run the following commands:
- `python -m pip install pre-commit`
- `pre-commit install`
- `pre-commit autoupdate`
- commit any changes made, and ensure that pre-commit functions as expected
- push like usual
