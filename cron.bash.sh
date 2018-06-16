#!/bin/bash
set -e

source /etc/environment
source /etc/profile

# Make sure $HOME/bin is in PATH
export PATH=$PATH:$HOME/bin

# restore SHELL env var for cron
SHELL=/bin/bash
# execute the cron command in an actual shell
exec /bin/bash --norc "$@"
