# Home Ansible Setup

## bootstrap.sh
- determine OS type: RHEL, Debian, CoreOS, other
- run pkg manager
    - update
    - install -y ansible git python2.7
- pull down Ansible playbooks, roles from git
- install and run playbooks based on which type the system is

## Playbooks
- base
    - base role only
- server (VM)
    - file server, VM, base, docker
    - db server: above + db
    - web server: above + web
- desktop (VM or BM)
    - home: chrome, audio, GUI, office, base
    - dev: chrome, GUI, base, db, docker, dev-python, dev-ruby, dev-go, dev-base
    - ops: chrome, GUI, base, docker, k8s, dev-base
    - all

## Roles
- VM: openvm tools
- Chrome: os specific, only 64-bit stable
- audio: spotify, audio codecs (gstreamer),  ffmpeg, mkvtools
- fileserver: smbd
- GUI: xfce, i3, and custom configs for both, simplenote, atom (sync-settings:restore)
- office: libreoffice, lyx, tex, dropbox
- dev-base: dbeaver, devtools, make, automake, git, git-review, git-flow
- dev-python: pycharms CE, virtualenv, pip, python2 and dev, python3 and dev, ipython
- dev-ruby: ruby, gem
- dev-go: golang, 
- base: VIM, htop, bwm-ng, smb client, ssh and configs, dotfiles, bash, zsh, wget, curl, powerline, vim config from github, the\_silver\_searcher, tmux and configs, 
- db: postgresql, mysql, db clients, sqlite
- docker: docker engine, docker compose, docker swarm
- k8s: minikube, kubernetes-cli, kubectl, terraform, chtf, 
- web server: apache, php
