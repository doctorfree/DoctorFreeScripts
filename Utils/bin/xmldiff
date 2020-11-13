#!/bin/bash
#
## @file xmldiff.sh
## @brief Display differences between two XML files after canonicalization
## @version 1.0.1
##
#

usage() {
    printf "\nUsage: xmldiff file1.xml file2.xml"
    exit 1
}

IN1="$1"
IN2="$2"

[ -r "$IN1" ] || {
    echo "First argument: $IN1, not readable. Exiting."
    usage
}
[ -d "$IN2" ] && IN2="$IN2"/"$IN1"
[ -r "$IN2" ] || {
    echo "Second argument: $IN2, not readable. Exiting."
    usage
}

XML1="/tmp/xmldiff1$$.xml"
XML2="/tmp/xmldiff2$$.xml"

xmllint --exc-c14n "$IN1" > $XML1
xmllint --exc-c14n "$IN2" > $XML2
diff $XML1 $XML2
rm -f $XML1 $XML2
