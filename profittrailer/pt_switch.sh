#!/bin/bash
#
# ptswitch - Switch ProfitTrailer trading strategies
# Usage: ptswitch <strategy> [market]
#    Where "strategy" must be one of:
#          default emagain emaspread lowbb moderate pioneers yuval
#    And "market" must be ETH or BTC. If no market is specified then the
#    installed ProfitTrailer market setting is used.

TOP="${HOME}/src/trading/profit-trailer"
DEST_BAS="${TOP}/binance"
DEST_DIR="${DEST_BAS}/installed"
INST_DIR=/usr/local/lib/ProfitTrailer
TRAD_DIR=${INST_DIR}/trading
STRG="default emagain emaspread lowbb moderate pioneers yuval"
P="PAIRS.properties"
MKTS="BTC ETH"
SRC=
MKT=
DEM=

usage() {
  echo "Usage: ptswitch <strategy> <market> where <strategy> must be one of"
  echo "    $STRG"
  echo "and <market> must be ETH or BTC"
  exit 1
}

chk_market() {
  match=
  for mrkt in ${MKTS}
  do
    [ "$MKT" == "$mrkt" ] && match=1
  done
  [ "$match" ] || {
    echo "Unsupported market $MKT specified. Exiting."
    usage
  }
}

get_market() {
  # Which market are we using?
  pairs="${TRAD_DIR}/$P"
  MKT=`grep ^MARKET ${pairs} | awk -F "=" ' { print $2 } '`
  MKT=`echo $MKT | sed -e "s/ //g"`
  echo "Installed MARKET = $MKT"
}

get_installed() {
  found=
  for bdir in ${STRG}
  do
    for market in ${MKTS}
    do
      cd ${DEST_BAS}/${bdir}/${market}
      # Both PAIRS and DCA must match
      # Ignore sell only entries as the blacklist utility adds them
      cat $P | grep -v _sell_only_mode > /tmp/P1$$
      cat ${TRAD_DIR}/$P | grep -v _sell_only_mode > /tmp/P2$$
      diff /tmp/P1$$ /tmp/P2$$ > /dev/null && {
        diff DCA.properties ${TRAD_DIR}/DCA.properties > /dev/null && {
          echo "Installed strategy is $bdir using the $market market"
          found=1
          break
        }
      }
      rm -f /tmp/P1$$ /tmp/P2$$
    done
    [ "$found" ] && break
  done
  [ "$found" ] || echo "No known strategy is installed"
}

[ "$1" == "-d" ] && {
    DEM=1
    echo "DEMO MODE: No changes will be made"
    shift
}

[ $# -eq 1 ] && get_market
[ $# -eq 2 ] && MKT="$2"
chk_market

STRAT="unknown"
for strat in $STRG
do
    [ "${strat}" == "$1" ] && {
        SRC="${TOP}/binance/${strat}"
        STRAT="${strat}"
        break
    }
done

[ "${SRC}" ] || {
    echo "No valid strategy provided. Exiting."
    usage
}

[ -d "${SRC}/${MKT}" ] || {
    echo "$SRC/${MKT} does not exist or is not a directory. Exiting."
    usage
}

[ -d ${DEST_DIR}/trading ] || {
    echo "${DEST_DIR}/trading does not exist or is not a directory. Exiting."
    usage
}

echo "Determining installed strategy ..."
get_installed

if [ "$DEM" ]
then
    echo "cp ${SRC}/${MKT}/* ${DEST_DIR}/trading"
else
    cp ${SRC}/${MKT}/* ${DEST_DIR}/trading
fi

[ "$DEM" ] || {
    echo "Checking differences in updated strategy and installed strategy ..."
    cd ${DEST_DIR}
    for i in *.properties *.json trading/*
    do
        diff $i ${INST_DIR}/$i > /dev/null || echo "$i differs"
    done
}
echo "Installing ${STRAT} trading strategy from $SRC using $MKT market"

if [ "$DEM" ]
then
    echo "cp ${DEST_DIR}/trading/* ${TRAD_DIR}"
else
    cp ${DEST_DIR}/trading/* ${TRAD_DIR}
fi
