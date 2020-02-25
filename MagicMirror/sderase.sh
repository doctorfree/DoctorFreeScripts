#!/bin/bash

DEVICE="/dev/rdisk3"

diskutil unmountDisk ${DEVICE}
sudo diskutil eraseDisk FAT32 RASPBIAN MBRFormat ${DEVICE}
