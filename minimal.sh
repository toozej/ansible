#!/usr/bin/env bash

command -v curl || apt install -y curl || dnf install -y curl
curl https://raw.githubusercontent.com/toozej/ansible/master/bootstrap.sh -O && chmod +x bootstrap.sh
./bootstrap.sh -r common.yml
