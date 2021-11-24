#!/bin/bash
#
## @file piclinks.sh
## @brief Create symbolic links to photo files where possible
## @remark Reduce duplicate storage of photographs, link to my Photos libraries
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 23-Mar-2014
## @version 1.0.1
##
## Based on vidlinks https://gitlab.com/doctorfree/DoctorFreeScripts/blob/master/vidlinks
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# The Software is provided "as is", without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose and noninfringement. In no event shall the
# authors or copyright holders be liable for any claim, damages or other
# liability, whether in an action of contract, tort or otherwise, arising from,
# out of or in connection with the Software or the use or other dealings in
# the Software.
#

[ "${PICROOT}" ] || PICROOT=/u/pictures
[ "${PHOROOT}" ] || PHOROOT=/Photos

P="$HOME/Pictures"
W="${PICROOT}"
LIBS="${PHOROOT}/Libraries"
TELL=
PICS=
QUICK=
SUMS="SUMS.txt"

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
    printf "\nUsage: piclinks [-P Pictures Dir] [-W Work Dir]"
    printf "\n\t[-A Photos/Aperture Libraries Dir] [-h] [-d] [-q] [-u]\n"
    printf "\nWhere:\n\t-d indicates tell me what you would do"
    printf "\n\t-h indicates also search Home Pictures directory"
    printf "\n\t-q indicates quick run (do not redo SUMS)"
    printf "\n\t-u displays this usage message\n"
    printf "\nDefaults are:\n\tHome Pictures Dir = $P"
    printf "\n\tWork Dir = $W"
    printf "\n\tPhotos/Aperture Libraries Dir = $LIBS\n\n"
    exit 1
}

## @fn remlink()
## @brief Remove file and replace it with a symbolic link
## @param param1 Source file to use for symbolic link
## @param param2 File to remove and replace
remlink() {
    printf "\nRemoving $2"
    [ "$TELL" ] || rm -f "$2"
    printf "\nLinking $1 to $2\n"
    [ "$TELL" ] || ln -s "$1" "$2"
}

## @fn FindAndLink()
## @brief Recursively find and symlink duplicate files in current directory
## @param none
FindAndLink() {
    find . -not \( -path ./Wallbase -prune \) -not \( -path ./Wallhaven -prune \) -type f | while read i
    do
        if [ -L "$i" ]
        then
            continue
        else
            b=`basename "$i"`
            [ "$b" = "${SUMS}" ] && continue
            # Backslash the brackets in any filenames so grep doesn't choke
            fixed=`echo "$i" | sed -e "s/\[/\\\\\[/g" -e "s/\]/\\\\\]/g"`
            ck1=`grep "$fixed" ${SUMS} | awk ' { print $1 } '`
            [ "$ck1" ] || ck1=`cksum "$i" | awk ' { print $1 } '`
            # Could be in multiple Aperture, migrated Aperture, or Photos
            # libraries, use the first one we find searching Photos then
            # Aperture then migrated Aperture.
            for lib in "$LIBS"/*.photoslibrary/Masters "$LIBS"/*.aplibrary/Masters "$LIBS"/*.migratedaplibrary/Masters
            do
                [ -d "$lib" ] && {
                    b=`grep "$ck1" "$lib/${SUMS}" | awk ' { for(i=3;i<NF;i++) printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS}'`
                    ck2=`echo $b | sed -e "s/\.\///"`
                    [ "$ck2" ] || continue
                    remlink "$lib/$ck2" "$i"
                    break
                }
            done
        fi
    done
}

## @fn FindAndRemove()
## @brief Recursively find and broken symbolic links in current directory
## @param none
FindAndRemove() {
    find . -type l | while read i
    do
        ls -lL "$i" > /dev/null 2>&1
        [ $? -eq 0 ] || {
            printf "\nRemoving $i"
            [ "$TELL" ] || rm -f "$i"
        }
    done
}

while getopts A:P:W:dhqu flag; do
    case $flag in
        A)
            LIBS="$OPTARG"
            ;;
        P)
            P="$OPTARG"
            ;;
        W)
            W="$OPTARG"
            ;;
        d)
            TELL=1
            ;;
        h)
            PICS=1
            ;;
        q)
            QUICK=1
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "$PICS" ] && {
    [ -d "$P" ] || {
        echo "$P does not exist or is not a directory. Exiting."
        exit 1
    }
}
[ -d "$W" ] || {
    echo "$W does not exist or is not a directory. Exiting."
    exit 1
}
[ -d "$LIBS" ] || {
    echo "$LIBS does not exist or is not a directory. Exiting."
    exit 1
}

# Update the Aperture libraries SUMS files first
cd "$LIBS"
[ "$QUICK" ] || {
    printf "\nUpdating Photos/Aperture libraries SUMS files ...\n"
    [ "$TELL" ] || {
        for aplib in *.photoslibrary/Masters *.aplibrary/Masters *.migratedaplibrary/Masters
        do
            [ -d "$aplib" ] && {
                cd "$aplib"
                updsums
                cd ../..
            }
        done
    }
}

# Link to file in Photos/Aperture library if it's a duplicate
if [ -d "$W" ]
then
    cd "$W"
    [ "$QUICK" ] || {
        printf "\nUpdating $W/${SUMS}\n"
        [ "$TELL" ] || updsums
    }
    printf "\nFinding and symlinking duplicate files in $W ...\n"
    FindAndLink
else
    echo "$W does not exist or is not a directory. Skipping."
fi
[ "$PICS" ] && {
    if [ -d "$P" ]
    then
        cd "$P"
        [ "$QUICK" ] || {
            printf "\nUpdating $P/${SUMS}\n"
            [ "$TELL" ] || updsums
        }
        printf "\nFinding and symlinking duplicate files in $P ...\n"
        FindAndLink
    else
        echo "$P does not exist or is not a directory. Skipping."
    fi
}

# Remove broken links
if [ -d "$W" ]
then
    cd "$W"
    printf "\nRemoving broken links in $W ...\n"
    FindAndRemove
else
    echo "$W does not exist or is not a directory. Skipping."
fi
[ "$PICS" ] && {
    if [ -d "$P" ]
    then
        cd "$P"
        printf "\nRemoving broken links in $P ...\n"
        FindAndRemove
    else
        echo "$P does not exist or is not a directory. Skipping."
    fi
}

printf "\n\nDone."
