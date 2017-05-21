# Home Ansible Setup

## bootstrap.sh
- determine OS type: RHEL, Debian, CoreOS, other
- run pkg manager
    - update
	- if RHEL, install EPEL repo
    - install -y ansible git python2.7
- pull down Ansible playbooks, roles from git
- install and run playbooks commond on which type the system is

## Playbooks
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

## Roles
- VM: openvm tools
- Chrome: os specific, only 64-bit stable
- audio: spotify, audio codecs (gstreamer),  ffmpeg, mkvtools
- fileserver: smbd
- GUI: xfce, i3, and custom configs for both, simplenote, atom (sync-settings:restore)
- office: libreoffice, lyx, tex, dropbox
- dev-common: dbeaver, devtools, make, automake, git, git-review, git-flow
- dev-python: pycharms CE, virtualenv, pip, python2 and dev, python3 and dev, ipython
- dev-ruby: ruby, gem
- dev-go: golang
- common: VIM, htop, bwm-ng, smb client, ssh and configs, dotfiles, bash, zsh, wget, curl, powerline, vim config from github, the\_silver\_searcher, tmux and configs, tree, screen
- db: postgresql, mysql, db clients, sqlite
- docker: docker engine, docker compose, docker swarm
- k8s: minikube, kubernetes-cli, kubectl, terraform, chtf, awscli
- web server: apache, php
