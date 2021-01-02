# Linux Server Hardening role

IMPORTANT: make sure you have a valid SSH key configured before you run this role, otherwise you will lock yourself out! 

Installs basic server hardening configurations including:
1. enabling fail2ban for SSH connections, and bans non-US connections to avoid provider egress fees
1. firewall using firewalld


Credit for this role goes to:
- <https://github.com/tasdikrahman/ansible-bootstrap-server/tree/master/roles/basic-server-hardening>
- <https://github.com/geerlingguy/ansible-role-firewall> for ideas around defaults
- <https://docs.ansible.com/ansible/latest/modules/firewalld_module.html>
- <https://github.com/Oefenweb/ansible-fail2ban>
- <https://munkjensen.net/wiki/index.php/Access_control_using_Fail2Ban_and_geoip>
