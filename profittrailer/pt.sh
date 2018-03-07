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
        echo "   pt [conservative|default|emaspread|lowbalance|moderate|pioneers|yuval]"
        echo "or"
        echo "   pt [status|start|stop|restart|delete]"
        echo "or"
        echo "   pt [disp|display|show|monit|tail]"
        echo ""
        exit 0
        ;;
    conservative|default|emaspread|lowbalance|moderate|pioneers|yuval)
        pm2 stop ${PT_DIR}/pm2-ProfitTrailer.json
        pt_switch $1
        pm2 start ${PT_DIR}/pm2-ProfitTrailer.json
        ;;
    disp|display)
        pt_disp
        ;;
    status|start|stop|restart|delete)
        pm2 $1 ${PT_DIR}/pm2-ProfitTrailer.json
        ;;
    show|monit)
        pm2 $1 profit-trailer-binance
        ;;
    tail)
        tail -f ${PT_DIR}/logs/ProfitTrailer.log
        ;;
    *)
        pt_disp
        pt help
        exit 1
        ;;
esac
exit 0

