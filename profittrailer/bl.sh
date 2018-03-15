#!/bin/bash

PT_DIR=/usr/local/lib/ProfitTrailer
LOG=ProfitTrailer-blacklist.log

[ -d ${PT_DIR} ] || {
    echo "${PT_DIR} does not exist or is not a directory. Exiting."
    exit 1
}

tailit() {
    inst=`type -p grcat`
    if [ "$inst" ]
    then
        tail -f ${PT_DIR}/logs/${LOG} | grcat conf.profittrailer
    else
        tail -f ${PT_DIR}/logs/${LOG}
    fi
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
        tailit
        ;;
    *)
        bl help
        exit 1
        ;;
esac
exit 0

