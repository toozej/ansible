Role Name
=========

The common role exists to simplify the inclusion of all the common roles.

Requirements
------------

All the dependent roles are required.

Role Variables
--------------

Each dependent role has it's own set of variables each with sane defaults.

Dependencies
------------

none

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: common, tags: 'common' }
