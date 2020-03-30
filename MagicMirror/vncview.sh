#!/bin/bash
#
# Set these to the IP address of the VNC Server and the user to login there
# Note: the user needs to have SSH public/private keys setup to automatically
#       authenticate and the user must have sudo privileges
#
IP=10.0.1.67
USER=pi

# Start VNC Server on MagicMirror
ssh ${USER}@${IP} "export TERM=xterm-256color; sudo systemctl start vncserver-x11-serviced.service"
sleep 3

# Run VNC Viewer on my Mac Pro
"/Applications/VNC Viewer.app/Contents/MacOS/vncviewer" -UserName=${USER} ${IP}

# Stop VNC Server on MagicMirror
ssh ${USER}@${IP} "export TERM=xterm-256color; sudo systemctl stop vncserver-x11-serviced.service"
