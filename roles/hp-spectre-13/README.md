Ansible Role for HP Spectre 13 fixes and settings under Linux


# suspend_fix_13-V001NF from https://github.com/PierreLeGuen/suspend_fix_13-V001NF
## Whats happening 
The Spectre 13 have a strange behavior with suspend under Linux. The power button blocks the suspend.
The /proc/acpi/wakeup file can't be edited directly, your modification won't stay. The service is here to disable it definitely.

## Tested and working on
-Debian Stretch

-Debian Buster

-ArchLinux

-Ubuntu 18.04 LTS

(Basically it should work on every systemd based distrib)

## Installation

<pre><code>
git clone https://github.com/PierreLeGuen/suspend_fix_13-V001NF
cd suspend_fix_13-V001NF
sudo cp suspendfix_pwrb.service /etc/systemd/system
sudo systemctl enable suspendfix_pwrb.service
sudo shutdown -r now
</code></pre>

## How to check if it works

<pre><code>
sudo nano /proc/acpi/wakeup
</code></pre>

The line with PWRB should be "disabled"
