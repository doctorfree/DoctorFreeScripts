#!/bin/bash
#
# tap2click - disable or enable the gnome desktop tap to click feature

case "$1" in
  off|Off|disable|Disable)
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
    ;;
  on|On|enable|Enable)
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
    ;;
  *)
    echo "Usage: tap2click off|on"
    ;;
esac
