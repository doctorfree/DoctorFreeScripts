#!/bin/bash
#
## @file audlinks.sh
## @brief Create symbolic links to song files where possible
## @remark Reduce duplicate storage of audio and link into my iTunes library
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 01-Dec-2013
## @version 1.0.1
##
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

[ "${AUDROOT}" ] || AUDROOT=/Audio
[ "${ITUROOT}" ] || ITUROOT=/iTunes

ITUNES="${ITUROOT}"
A="${ITUNES}/Audiobooks"
I="${ITUNES}/Music"
M="$HOME/Music"
W="${AUDROOT}/Imported"
B="${W}/Audiobooks"
WORK=1
MUSE=
BOOK=
USE_SUM=
TELL=

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
    printf "\nUsage: audlinks [-M Music Dir] [-W Work Dir]"
    printf "\n\t[-I iTunes Dir] [-a] [-b] [-d] [-c] [-m] [-u]\n"
    printf "\nWhere:\n\t-d indicates tell me what you would do"
    printf "\n\t-a indicates search audiobooks directory"
    printf "\n\t-b indicates search both work and music directories"
    printf "\n\t-c indicates use chksums"
    printf "\n\t-m indicates only search music directory"
    printf "\n\t-u displays this usage message\n"
    printf "\nDefaults are:\n\tMusic Dir = $M"
    printf "\n\tWork Dir = $W"
    printf "\n\tiTunes Dir = $I\n"
    printf "\nBy default only the work directory is searched.\n\n"
    exit 1
}

## @fn remlink()
## @brief Remove file and replace with symbolic link
## @param param1 first argument to function is source file for symbolic link
## @param param2 second argument is file to remove and replace with symlink
remlink() {
    printf "\nRemoving $2"
    [ "$TELL" ] || rm -f "$2"
    printf "\nLinking $1 to $2\n"
    [ "$TELL" ] || ln -s "$1" "$2"
}

## @fn FindAndLink()
## @brief Remove file and replace with symbolic link
## @param param1 first argument is directory path in which to find files
FindAndLink() {
    T="$1"
    abook=
    [ "$T" = "$A" ] && {
        abook=1
        # iTunes doesn't use the audiobook title in its library hierarchy
        title=
    }
    find . -type f | while read i
    do
        found=
        if [ -L "$i" ]
        then
            continue
        else
            b=`basename "$i"`
            echo "$b" | grep ":" > /dev/null && {
                b=`echo "$b" | sed -e "s/:/_/g"`
            }
            d=`dirname "$i"`
            [ "$abook" ] || {
                title=`basename "$d"`
                echo "$title" | grep ":" > /dev/null && {
                    title=`echo "$title" | sed -e "s/:/_/g"`
                }
            }
            e=`dirname "$d"`
            artist=`basename "$e"`
            [ "$b" = "SUMS" ] && continue
            [ "$USE_SUM" ] && {
                ck1=`grep "$i" SUMS | awk ' { print $1 } '`
                [ "$ck1" ] || ck1=`cksum "$i" | awk ' { print $1 } '`
            }
            [ -f "$T/$artist/$title/$b" ] && found="$b"
            [ "$found" ] || {
                # Check for file with track number added as prefix
                [ -d "$T/$artist/$title" ] && {
                    pushd "$T/$artist/$title" > /dev/null
                    for song in [0-9][0-9]*
                    do
                        notrack=${song:3}
                        if [ "$b" = "$notrack" ]
                        then
                            found="$song"
                            break
                        fi
                    done
                    popd > /dev/null
                }
            }
            [ "$found" ] && {
                if [ "$USE_SUM" ]
                then
                    ck2 =`grep "$found" "$T/SUMS" | awk ' { print $1 } '`
                    [ "$ck2" ] || ck2=`cksum "$T/$artist/$title/$found" | awk ' { print $1 } '`
                    [ $ck1 -eq $ck2 ] && {
                        remlink "$T/$artist/$title/$found" "$i"
                    } 
                else
                    remlink "$T/$artist/$title/$found" "$i"
                fi
            }
            [ "$found" ] || {
                [ "$TELL" ] && continue
                # Maybe the filename in iTunes has been changed. Search the SUMS
                [ "$USE_SUM" ] && {
                    iname=`grep $ck1 "$ISUMS"`
                    [ "$iname" ] && {
                        b=`echo $iname | awk ' { for(i=3;i<NF;i++) printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS}'`
                        b=`echo $b | sed -e "s/\.\///"`
                        remlink "$T/$b" "$i"
                    }
                }
            }
        fi
    done
}

## @fn FindAndRemove()
## @brief Recursively remove broken symbolic links in specified directory
## @param param1 first argument is directory path in which to find symlinks
FindAndRemove() {
    find . -type l | while read i
    do
        ls -lL "$i" > /dev/null 2>&1
        [ $? -eq 0 ] || {
            printf "\nRemoving $i"
            [ "$TELL" ] || rm -f "$i"
        }
    done
    printf "\n"
}

while getopts M:W:I:abdcmu flag; do
    case $flag in
        M)
            M="$OPTARG"
            ;;
        W)
            W="$OPTARG"
            ;;
        I)
            I="$OPTARG"
            ;;
        a)
            BOOK=1
            ;;
        b)
            MUSE=1
            ;;
        d)
            TELL=1
            ;;
        c)
            USE_SUM=1
            ;;
        m)
            MUSE=1
            WORK=
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ -d "$I" ] || {
    echo "$I does not exist or is not a directory. Exiting."
    exit 1
}

ISUMS="$I"/SUMS
# Not using this yet
WSUMS="$W"/SUMS
MSUMS="$M"/SUMS

# Update the iTunes SUMS file first
[ "$USE_SUM" ] && {
    cd "$I"
    printf "\nUpdating iTunes SUMS file ...\n"
    [ "$TELL" ] || updsums
}

[ "$WORK" ] && {
  # Link to file in iTunes library if it's a duplicate
  if [ -d "$W" ]
  then
    cd "$W"
    # Update the SUMS file if we are using cksums
    [ "$USE_SUM" ] && {
        printf "\nUpdating $W/SUMS\n"
        [ "$TELL" ] || updsums
    }
    printf "\nFinding and symlinking duplicate files in $W ...\n"
    FindAndLink "$I"
  else
    echo "$W does not exist or is not a directory. Skipping."
  fi
}

[ "$BOOK" ] && {
  if [ -d "$B" ]
  then
    cd "$B"
    # Update the SUMS file if we are using cksums
    [ "$USE_SUM" ] && {
        printf "\nUpdating $M/SUMS\n"
        [ "$TELL" ] || updsums
    }
    printf "\nFinding and symlinking duplicate files in $B ...\n"
    FindAndLink "$A"
  else
    echo "$B does not exist or is not a directory. Skipping."
  fi
}

[ "$MUSE" ] && {
  if [ -d "$M" ]
  then
    cd "$M"
    # Update the SUMS file if we are using cksums
    [ "$USE_SUM" ] && {
        printf "\nUpdating $M/SUMS\n"
        [ "$TELL" ] || updsums
    }
    printf "\nFinding and symlinking duplicate files in $M ...\n"
    FindAndLink "$I"
  else
    echo "$M does not exist or is not a directory. Skipping."
  fi
}

[ "$WORK" ] && {
  # Remove broken links
  if [ -d "$W" ]
  then
    cd "$W"
    printf "\nRemoving broken links in $W ...\n"
    FindAndRemove
  else
    echo "$W does not exist or is not a directory. Skipping."
  fi
}

[ "$MUSE" ] && {
  if [ -d "$M" ]
  then
    cd "$M"
    printf "\nRemoving broken links in $M ...\n"
    FindAndRemove
  else
    echo "$M does not exist or is not a directory. Skipping."
  fi
}

echo "Done."
