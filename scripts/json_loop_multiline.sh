#!/bin/bash
#
# json_loop_multiline - iterate over a JSON array even
#                       if it contains multiline values
#
# From: https://www.starkandwayne.com/blog/bash-for-loop-over-json-array-using-jq
#
# Sometimes you just want to read a JSON config file from Bash and iterate
# over an array. For example, when seeding some credentials to a credential
# store. This sometimes can be tricky especially when the JSON contains
# multi-line strings (for example certificates).
#
# This can be done with jq and a Bash for loop using base64 encoding:

sample='[{"name":"foo"},{"name":"bar"}]'
for row in $(echo "${sample}" | jq -r '.[] | @base64'); do
    _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
    }
   echo $(_jq '.name')
done
