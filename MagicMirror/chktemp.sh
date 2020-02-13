#!/bin/bash
#
# chktemp - Get the Raspberry Pi temperature and SMS that using Nexmo, shutdown if too hot

TEMPC=`vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*'`
TEMPF=`echo "scale=2; 1.8 * ${TEMPC} + 32" | bc`
DATE=`date "+%b %d, %Y"`
TIME=`date "+%T"`

sendsms() {
    MESSAGE="$*"

    curl -X "POST" "https://rest.nexmo.com/sms/json" \
         -d "from=xxxxxxxxxxx" \
         -d "text=${MESSAGE}" \
         -d "to=xxxxxxxxxxx" \
         -d "api_key=xxxxxxxx" \
         -d "api_secret=xxxxxxxxxxxxxxxx"
}

printf "\n${DATE}:${TIME} Temp = ${TEMPF}F\t${TEMPC}C\n"

sendsms On ${DATE} at ${TIME} the Raspberry Pi temp is ${TEMPF}F ${TEMPC}C

# Shutdown if temperature exceeds some reasonable threshold
if [ "${TEMPC}" ]
then
    [ $(echo "${TEMPC} > 75.0" | bc -l) ] || {
        sendsms Raspberry Pi temperature of ${TEMPC} exceeds heat threshold. Shutting down.
        /usr/local/bin/shutdown
    }
else
    if [ "${TEMPF}" ]
    then
        [ $(echo "${TEMPF} > 167.0" | bc -l) ] || {
            sendsms Raspberry Pi temperature of ${TEMPF} exceeds heat threshold. Shutting down.
            /usr/local/bin/shutdown
        }
    else
        echo "Unable to retrieve non-empty temperature for Raspberry Pi"
    fi
fi
