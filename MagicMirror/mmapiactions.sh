#!/bin/bash

apikey="MMM-Remote-Control_API_Key"

curl -X GET http://10.0.1.67:8080/api/modules?apiKey=${apikey} | jq .
