#!/bin/bash
#
# trashcan - hide or show the gnome desktop trash icon

case "$1" in
  hide|Hide|h|H)
    gsettings set org.gnome.shell.extensions.ding show-trash false
    ;;
  show|Show|s|S)
    gsettings set org.gnome.shell.extensions.ding show-trash true
    ;;
  *)
    echo "Usage: trashcan hide|show"
    ;;
esac
