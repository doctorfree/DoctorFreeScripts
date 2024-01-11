#!/bin/bash
#
# Retrieve BIOS information
# Requires sudo privilege

have_dmi=$(type -p dmidecode)
have_lsh=$(type -p lshw)

# Assumes Debian based system with apt package manager
[ "${have_dmi}" ] || sudo apt install dmidecode -q -y
[ "${have_lsh}" ] || sudo apt install lshw -q -y

printf "\nOutput of dmidecode Vendor/Product:\n"
sudo dmidecode | grep -A3 'Vendor:\|Product:'

printf "\nOutput of lshw product/vendor:\n"
sudo lshw -C cpu | grep -A3 'product:\|vendor:'
