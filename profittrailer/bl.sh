#!/bin/bash

PT_DIR=/usr/local/lib/ProfitTrailer

[ -d ${PT_DIR} ] || {
    echo "${PT_DIR} does not exist or is not a directory. Exiting."
    exit 1
}

cd ${PT_DIR}

case "$1" in
    help|usage)
        echo ""
        echo "Usage:"
        echo "   bl [status|start|stop|restart|delete]"
        echo "or"
        echo "   bl [show|monit|tail]"
        echo ""
        exit 0
        ;;
    start)
        /usr/local/bin/blacklist_start
        ;;
    status|stop|restart|delete)
        pm2 $1 blacklist
        ;;
    show|monit)
        pm2 $1 blacklist
        ;;
    tail)
        tail -f ${PT_DIR}/logs/ProfitTrailer-blacklist.log
        ;;
    *)
        bl help
        exit 1
        ;;
esac
exit 0

