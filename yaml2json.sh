#!/bin/bash
#
# yaml2json - convert a YAML format file to the equivalent JSON format file
#
# Written 2-Feb-2017 by Ron Record <rrecord at vmware dot com>
#
# Usage: yaml2json filename.yaml
#        or
#        yaml2json filename_without_suffix
#

YAML="$1.yaml"
JSON="$1.json"

[ -r "$YAML" ] || {
    YAML=`echo $YAML | sed -e "s/.yaml//"`
    [ -r "$YAML" ] || {
        echo "$YAML does not exist or is not readable. Exiting."
        exit 1
    }
    JSON=`echo $YAML | sed -e "s/.yaml/\.json/"`
}

[ -r "$JSON" ] && {
    echo "$JSON already exists. Exiting."
    exit 1
}

python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)' < "$YAML" > "$JSON"
