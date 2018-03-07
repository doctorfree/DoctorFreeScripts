#!/bin/bash
#
# ptdisp - Display ProfitTrailer trading strategy

TOP="${HOME}/src/trading/profit-trailer"
DEST_DIR="${TOP}/binance"
INST_DIR=/usr/local/lib/ProfitTrailer/trading
STRG="conservative default emaspread lowbalance moderate pioneers yuval"
P="PAIRS.properties"

# Which market are we using?
market=`grep ^MARKET ${INST_DIR}/$P | awk -F "=" ' { print $2 } '`
market=`echo $market | sed -e "s/ //g"`
echo "Using MARKET = $market"

echo "Determining installed strategy ..."
found=
for bdir in ${STRG}
do
    cd ${DEST_DIR}/${bdir}/${market}
    # Both PAIRS and DCA must match
    # Ignore sell only entries as the blacklist utility adds them
    cat $P | grep -v _sell_only_mode > /tmp/P1$$
    cat ${INST_DIR}/$P | grep -v _sell_only_mode > /tmp/P2$$
    diff /tmp/P1$$ /tmp/P2$$ > /dev/null && {
      diff DCA.properties ${INST_DIR}/DCA.properties > /dev/null && {
        echo "Installed strategy is $bdir"
        found=1
        break
      }
    }
    rm -f /tmp/P1$$ /tmp/P2$$
done

[ "$found" ] || echo "No known strategy is installed"
