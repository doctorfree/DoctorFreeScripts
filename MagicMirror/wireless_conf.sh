#!/bin/bash
#
PASSFILE="$HOME/.wireless"
CONFFILE="/etc/wpa_supplicant/wpa_supplicant.conf"
# Test configuration file
#CONFFILE="$HOME/src/Scripts/MagicMirror/etc/wpa_supplicant/wpa_supplicant.conf"

[ -f ${PASSFILE} ] || {
    echo "${PASSFILE} does not exist or is not a regular file."
    echo "See $HOME/src/Scripts/MagicMirror/wireless_dot_sample"
    echo "for a sample ${PASSFILE}"
    echo "Exiting"
    exit 1
}

. ${PASSFILE}

# Uncomment for testing purposes
#echo "PASSFILE=${PASSFILE}"
#echo "CONFFILE=${CONFFILE}"
#echo "ssid=${SSID}"
#echo "psk=${PSK}"
wpa_passphrase "${SSID}" "${PSK}" | sudo tee -a ${CONFFILE} > /dev/null
#echo "Now run: wpa_cli -i wlan0 reconfigure"
wpa_cli -i wlan0 reconfigure
