#!/bin/bash
for fs in Seagate_8TB WD_My_Passport_4TB
do
    mount | grep -v /etc/auto.mount | grep $fs > /dev/null && sudo umount /home/pi/$fs
done
sudo /sbin/shutdown -r now
