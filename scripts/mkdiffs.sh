#!/bin/bash
#
## @file mkdiffs.sh
## @brief Diff current git repo versions against installed versions
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 24-Sep-2016
## @version 1.0.1
##

HBIN="${HOME}/bin"

create_diff() {
    case "$1" in
        bash_aliases)
            dnum=`diff "$1" "$2" | wc -l`
            [ $dnum -ne 121 ] && {
                echo "Creating /tmp/$3.diff"
                diff $1 $2 > /tmp/$3.diff
            }
            ;;
        bash_profile)
            dnum=`diff "$1" "$2" | wc -l`
            [ $dnum -ne 8 ] && {
                echo "Creating /tmp/$3.diff"
                diff $1 $2 > /tmp/$3.diff
            }
            ;;
        bashrc)
            dnum=`diff "$1" "$2" | wc -l`
            [ $dnum -ne 58 ] && {
                echo "Creating /tmp/$3.diff"
                diff $1 $2 > /tmp/$3.diff
            }
            ;;
        mkreadme.sh|mkwmv.sh)
            dnum=`diff "$1" "$2" | wc -l`
            [ $dnum -ne 12 ] && {
                echo "Creating /tmp/$3.diff"
                diff $1 $2 > /tmp/$3.diff
            }
            ;;
        *)
            cmp -s $1 $2 || {
                echo "Creating /tmp/$3.diff"
                diff $1 $2 > /tmp/$3.diff
            }
            ;;
    esac
}

diffit() {
    f="$1"
    if [ -f "$f" ]
    then
        j=`echo $1 | sed -e "s/\.sh//"`
        if [ -f $HBIN/$j ]
        then
            create_diff $f $HBIN/$j $j
        else
            if [ -f /usr/local/bin/$j ]
            then
                create_diff $f /usr/local/bin/$j $j
            else
                # See if it's a shell configuration file in $HOME
                if [ -f ${HOME}/.$j ]
                then
                    create_diff $f ${HOME}/.$j $j
                else
                    printf "\n"
                    printf "Installed $j does not exist or is not a plain file."
                    echo " Skipping.\n"
                fi
            fi
        fi
    else
        echo "$f does not exist or is not a plain file. Skipping."
    fi
}

if [ "$1" ]
then
    for i in $*
    do
        diffit "$i"
    done
else
    for i in *.sh bash_aliases bash_profile bashrc dircolors vimrc
    do
        [ "$i" = "progress_bar.sh" ] && continue
        diffit "$i"
    done
fi
