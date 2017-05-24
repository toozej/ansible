# Audio Tools GUI Ansible Role

Installs GUI audio tools including: Spotify, gstreamer1.0, and gstreamer1.0
plugins. Is not a git submodule and doesn't auto-update

The Spotify installation section is based roughly off a combination of 
https://github.com/iknite/ansible-spotify and 
https://github.com/cmprescott/ansible-role-chrome in order to install Spotify
on DEB based as well as RPM based systems. RPM Repo information comes from
https://fedoraproject.org/wiki/Spotify
