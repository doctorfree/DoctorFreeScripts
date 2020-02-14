#!/bin/bash
#
# mm - execute the MagicMirror mirror script remotely using ssh
#
# Set these to be the user and IP address of the Raspberry Pi driving the MagicMirror
USER=pi
IP=10.0.1.67

ssh ${USER}@${IP} "export TERM=xterm-256color; mirror $*"
