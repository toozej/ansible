# repo-extra Ansible role

Borrowed from https://github.com/groks/ansible-repo-extra and modified to use 
dnf instead of yum. This role is not a git submodule and does not auto-update

installs the [rpmfusion](http://rpmfusion.org) free, nonfree, and
[livna](http://rpm.livna.org/) dnf repositories which contain extra software
packages [not available](https://fedoraproject.org/wiki/Forbidden_items) in the
standard Fedora repositories.

After enabling the role you must explicitly install the packages you want:

    ---
    - hosts: localhost

      roles:
        - repo-extra

      tasks:
        - name: install packages not in the main fedora repos
          dnf: name={{ item }} state=present
          with_items:
            - gstreamer-plugins-bad
            - freetype-freeworld
            - libdvdcss
            - VirtualBox

Get a list of the available packages by running the following command:

    dnf --disablerepo="*" \
        --enablerepo="rpmfusion-free,rpmfusion-nonfree,livna" \
        list available | grep -v i686

Requirements
------------

An installation of Fedora.
