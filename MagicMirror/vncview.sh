#!/bin/bash
#

IP=10.0.1.67

# Start VNC Server on MagicMirror
ssh pi@${IP} "export TERM=xterm-256color; sudo systemctl start vncserver-x11-serviced.service"
sleep 3

# Run VNC Viewer on my Mac Pro
"/Applications/VNC Viewer.app/Contents/MacOS/vncviewer" ${IP}

# Stop VNC Server on MagicMirror
ssh pi@${IP} "export TERM=xterm-256color; sudo systemctl stop vncserver-x11-serviced.service"
