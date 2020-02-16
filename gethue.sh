#!/bin/bash
#
# gethue - Get the Philips Hue hub user name, info, lights, etc
#
# To get started with instructions on retrieving a user id to use, see:
#     https://developers.meethue.com/develop/get-started-2/
# and
#     https://developers.meethue.com/develop/get-started-2/core-concepts/
#
# Currently, The seven available Hue resources to interact with are:
#
#     /lights resource which contains all the light resources
#     /groups resource which contains all the groups
#     /config resource which contains all the configuration items
#     /schedules which contains all the schedules
#     /scenes which contains all the scenes
#     /sensors which contains all the sensors
#     /rules which contains all the rules
#
# Set the IP and User to use (see instructions in URL above to retrieve this info)
IP=xx.x.x.x
USER="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

usage() {
    printf "\nUsage: gethue [lights|groups|config|schedules|scenes|sensors|rules]"
    printf "\nWhere no argument will retrieve all hub info"
    printf "\nand one of the following arguments can be given to retrieve info on:"
    printf "\n\tlights - all the light resources"
    printf "\n\tgroups - all the groups"
    printf "\n\tconfig - all the configuration items"
    printf "\n\tschedules - all the schedules"
    printf "\n\tscenes - all the scenes"
    printf "\n\tsensors - all the sensors"
    printf "\n\trules - all the rules\n"
    exit 1
}

# Check the argument
if [ "$1" ]
then
    case "$1" in
        lights|groups|config|schedules|scenes|sensors|rules)
            usejq=`type -p jq`
            if [ "$usejq" ]
            then
                curl -X "GET" "http://${IP}/api/${USER}/$1" 2> /dev/null | jq .
            else
                curl -X "GET" "http://${IP}/api/${USER}/$1"
            fi
            ;;
        *)
            usage
            ;;
    esac
else
    usejq=`type -p jq`
    if [ "$usejq" ]
    then
        curl -X "GET" "http://${IP}/api/${USER}" 2> /dev/null | jq .
    else
        curl -X "GET" "http://${IP}/api/${USER}"
    fi
fi
#
# TODO: convert to getopts arg processing
#while getopts lgcsru flag; do
#    case $flag in
#        u)
#            usage
#            ;;
#    esac
#done
#
# TODO: provide support for actions on lights/groups/etc
# To turn light id 1 on/off with hue saturation etc:
# curl -X "PUT" "http://${IP}/api/${USER}/lights/1/state" \
#     -d {"on":true, "sat":254, "bri":254,"hue":10000}
