#!/bin/bash

# Get the current brightness setting
curl -X GET http://10.0.1.67:8080/api/brightness | jq .
