# Validation

CI uses containers based on Debian 13. CI checks all playbook entry points with
`--syntax-check`. CI also runs `tests/compatibility.yml` with `--check`.
The compatibility playbook gathers facts, reads role variables, and checks
repository templates. It does not install packages or configure services.
A successful run reports `changed=0`.

The Python and ansible-core matrix follows the upstream support matrix:

| Python | ansible-core |
| --- | --- |
| 3.11 | 2.19 |
| 3.12, 3.13 | 2.19, 2.20, 2.21 |
| 3.14 | 2.20, 2.21 |

A separate job checks the Ansible packages from Debian 13. The minimum
ansible-core version is 2.19.11. Python 3.15 is outside the upstream support
matrix for these Ansible releases.

To check the Debian packages in a container, run these commands from the
repository root:

```sh
docker build -t ansible-check -f dockerfiles/Dockerfile_debian_stable .
docker run --rm -v "$PWD:/work:ro" ansible-check python3 tests/validate.py
```

To use a Python virtual environment inside a Debian 13 container, install the
requirements before the checks:

```sh
python3 -m venv /tmp/ansible-check
. /tmp/ansible-check/bin/activate
python -m pip install -r requirements-lint.txt
ansible-galaxy collection install -r requirements.yml
yamllint --strict .
ansible-lint --strict
python tests/validate.py
```

The Dockerfiles in `dockerfiles/archive/` describe retired environments. CI
and Jenkins do not use those files.

The other playbooks in `tests/` describe provisioning scenarios. The validation
script checks their syntax. It does not execute their provisioning tasks.
These checks do not validate package availability, external downloads, hardware,
or a complete machine installation.

The lint configuration retains three exceptions. Existing role paths contain
hyphens. Roles share variables for package and user settings. Provisioning also
updates packages to their latest distribution versions. The configuration keeps
all other default rules active. Both linters treat warnings as failures.

References:

- [Debian 13 ansible-core package](https://packages.debian.org/trixie/ansible-core)
- [Ansible support matrix](https://docs.ansible.com/projects/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix)
