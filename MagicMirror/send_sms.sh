#!/bin/bash

MESSAGE="$*"

curl -X "POST" "https://rest.nexmo.com/sms/json" \
     -d "from=xxxxxxxxxxx" \
     -d "text=${MESSAGE}" \
     -d "to=xxxxxxxxxxx" \
     -d "api_key=xxxxxxxx" \
     -d "api_secret=xxxxxxxxxxxxxxxx"
