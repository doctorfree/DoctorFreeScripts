#!/bin/bash
#
CONFDIR=$HOME/MagicMirror/config
[ -d ${CONFDIR} ] || {
    echo "$CONFDIR does not exist or is not a directory. Exiting."
    exit 1
}

cd ${CONFDIR}
if [ "$1" == "all" ]
then
    current=`ls -l config.js | awk ' { print $11 } '`
    echo "Saving $current MagicMirror configuration"
    for config in config-*.js
    do
        [ "$config" == "config-*.js" ] && {
            echo "No MagicMirror configuration files config-*.js found in $CONFDIR"
            continue
        }
        rm -f config.js
        ln -s ${config} config.js
        echo "Checking ${config} ..."
        npm run --silent config:check
        echo "Done"
    done
    echo "Restoring $current MagicMirror configuration"
    rm -f config.js
    ln -s ${current} config.js
else
    npm run --silent config:check
fi
