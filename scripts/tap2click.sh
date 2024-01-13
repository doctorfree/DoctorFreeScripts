#!/bin/bash
#
# tap2click - disable or enable the gnome desktop tap to click feature
#

case "$1" in
  gdmoff)
    sudo xhost +SI:localuser:gdm
    sudo -u gdm dbus-launch \
      gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
    ;;
  gdm|gdmon)
    sudo apt install dbus-x11 -q -y
    sudo xhost +SI:localuser:gdm
    sudo -u gdm dbus-launch \
      gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
    ;;
  off|Off|disable|Disable)
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
    ;;
  on|On|enable|Enable)
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
    ;;
  *)
    echo "Usage: tap2click off|on|gdm|gdmoff"
    ;;
esac
