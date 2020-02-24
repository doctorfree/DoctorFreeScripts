#!/bin/bash
#
usage() {
    echo "Usage: getquote symbol"
    echo "Where 'symbol' is ETHUSDT or BTCUSDT for crypto and AAPL or GOOG for stocks"
    exit 1
}

[ "$1" ] || usage

exch="stock"
echo $1 | grep USDT > /dev/null && exch="crypto"

usejq=`type -p jq`
if [ "$usejq" ]
then
    curl -X GET https://cloud.iexapis.com/v1/$exch/$1/quote?token='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' 2> /dev/null | jq .
else
    curl -X GET https://cloud.iexapis.com/v1/$exch/$1/quote?token='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    echo ""
fi
