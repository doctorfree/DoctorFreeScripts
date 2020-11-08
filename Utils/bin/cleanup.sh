#!/bin/bash
#Cleanup.sh(it)
sudo su - ethos -c "/bin/bash -c history -c"
sudo service rsyslog stop
sudo rm -rf /core
sudo rm -rf /var/lib/mlocate/mlocate.db
sudo rm -rf /root/.ssh/authorized_keys
sudo rm -rf /root/.ssh/known_hosts
sudo rm -rf /root/.ssh/id*
sudo rm -rf /root/.nano_history
sudo rm -f /home/ethos/.xsession-errors
sudo rm -f /root/.xsession-errors
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/cache/apt/*
sudo rm -rf /var/backups/*
sudo rm -rf /var/tmp/*
sudo rm -rf /root/.gitconfig
sudo rm -rf /root/.bash_history
sudo rm -rf /root/.viminfo
sudo rm -rf /root/.pip/pip.log
sudo rm -rf /home/ethos/.ssh/authorized_keys
sudo rm -rf /home/ethos/.ssh/known_hosts
sudo rm -rf /home/ethos/.ssh/id*
sudo rm -rf /var/lib/apt/lists
sudo rm -rf /home/ethos/.xsession-errors
sudo rm -rf /home/ethos/.xsession-errors.old
sudo rm -rf /home/ethos/.bash_history
sudo rm -rf /home/ethos/.history
sudo rm -rf /home/ethos/.backup
sudo rm -rf /home/ethos/.zcompdump
sudo rm -rf /home/ethos/.zcompdump*
sudo rm -rf /home/ethos/.gitconfig
sudo rm -rf /home/ethos/.nano_history
sudo rm -f /home/ethos/.ethash/full*
sudo rm -rf /var/log/installer
for f in $(find /var/log -name '*.gz' -or -name '*.1' -or -name '*.old'); do sudo rm $f; done
for f in $(find /var/log -name '*.log' -or -name '*_log' -or -name 'history' -or -name 'checkroot' -or -name 'checkfs'); do sudo echo "" > $f; done
sudo echo "" > /var/log/syslog
sudo echo "" > /var/log/dmesg
sudo echo "" > /var/log/btmp
sudo echo "" > /var/log/lastlog
sudo echo "" > /var/log/udev
sudo echo "" > /var/log/wtmp

history -c


