# Linux Server Hardening role

IMPORTANT: make sure you have a valid SSH key configured before you run this role, otherwise you will lock yourself out! 

Installs basic server hardening configurations including:
1. disallow root SSH access
1. disallow SSH password authentication
1. firewall using iptables
- After the role is run, a firewall init service will be available on the server. You can use service firewall [start|stop|restart|status] to control the firewall.


Credit for this role goes to https://github.com/tasdikrahman/ansible-bootstrap-server/tree/master/roles/basic-server-hardening 
and https://github.com/geerlingguy/ansible-role-firewall
