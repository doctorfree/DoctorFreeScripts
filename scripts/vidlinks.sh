#!/bin/bash
#
## @file vidlinks.sh
## @brief Create symbolic links to movie files where possible
## @remark Reduce duplicate storage of movies, link into my iTunes library
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 01-Dec-2013
## @version 1.0.1
##
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

[ "${MEDROOT}" ] || MEDROOT=/u
[ "${PICROOT}" ] || PICROOT=/u/pictures
[ "${VIDROOT}" ] || VIDROOT=/u/movies
[ "${AUDROOT}" ] || AUDROOT=/Audio
[ "${PHOROOT}" ] || PHOROOT=/Photos
[ "${ITUROOT}" ] || ITUROOT=/iTunes
[ "${MNTROOT}" ] || {
    USER=`id -u -n`
    MNTROOT=/media/${USER}
}

A="${VIDROOT}/SlideShows"
M="$HOME/Movies"
I="${ITUROOT}/Home Videos"
W="${VIDROOT}"
F="$W/Femjoy"
USE_SUM=
TELL=
FEMJOY=
SUMS="SUMS.txt"

## @fn usage()
## @brief Display command line usage options
## @param none
##
## Exit the program after displaying the usage message and example invocations
usage() {
    printf "\nUsage: vidlinks [-M Movies Dir] [-W Work Dir] [-F Femjoy Dir]"
    printf "\n\t[-A Aperture Dir] [-I iTunes Dir] [-d] [-c] [-j] [-u]\n"
    printf "\nWhere:\n\t-d indicates tell me what you would do"
    printf "\n\t-c indicates use chksums"
    printf "\n\t-j indicates populate the Femjoy \"All\" folder"
    printf "\n\t-u displays this usage message\n"
    printf "\nDefaults are:\n\tMovies Dir = $M"
    printf "\n\tWork Dir = $W"
    printf "\n\tFemjoy Dir = $F"
    printf "\n\tAperture Dir = $A"
    printf "\n\tiTunes Dir = $I\n\n"
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
    find . -type f | while read i
    do
        found=
        if [ -L "$i" ]
        then
            continue
        else
            # Backslash the brackets in any filenames so grep doesn't choke
            b=`basename "$i" | sed -e "s/\[/\\\\\[/g" -e "s/\]/\\\\\]/g"`
            [ "$b" = "${SUMS}" ] && continue
            [ "$USE_SUM" ] && {
                fixed=`echo "$i" | sed -e "s/\[/\\\\\[/g" -e "s/\]/\\\\\]/g"`
                ck1=`grep "$fixed" ${SUMS} | awk ' { print $1 } '`
                [ "$ck1" ] || ck1=`cksum "$i" | awk ' { print $1 } '`
            }
            [ -f "$I/$b" ] && {
                found=1
                if [ "$USE_SUM" ]
                then
                    ck2 =`grep "$b" "$I/${SUMS}" | awk ' { print $1 } '`
                    [ "$ck2" ] || ck2=`cksum "$I/$b" | awk ' { print $1 } '`
                    [ $ck1 -eq $ck2 ] && {
                        remlink "$I/$b" "$i"
                    } 
                else
                    remlink "$I/$b" "$i"
                fi
            }
            [ $found ] || {
                [ "$TELL" ] && continue
                # Maybe the filename in iTunes has been changed. Search the SUMS
                [ "$USE_SUM" ] && {
                    iname=`grep $ck1 "$ISUMS"`
                    [ "$iname" ] && {
                        b=`echo $iname | awk ' { for(i=3;i<NF;i++) printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS}'`
                        b=`echo $b | sed -e "s/\.\///"`
                        remlink "$I/$b" "$i"
                    }
                }
            }
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

while getopts A:M:W:F:I:dcju flag; do
    case $flag in
        A)
            A="$OPTARG"
            ;;
        M)
            M="$OPTARG"
            ;;
        W)
            W="$OPTARG"
            ;;
        F)
            F="$OPTARG"
            ;;
        I)
            I="$OPTARG"
            ;;
        d)
            TELL=1
            ;;
        c)
            USE_SUM=1
            ;;
        j)
            FEMJOY=1
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ -d "$M" ] || {
    echo "$M does not exist or is not a directory. Exiting."
    exit 1
}
[ -d "$W" ] || {
    echo "$W does not exist or is not a directory. Exiting."
    exit 1
}
[ -d "$F" ] || {
    echo "$F does not exist or is not a directory. Exiting."
    exit 1
}
[ -d "$I" ] || {
    echo "$I does not exist or is not a directory. Exiting."
    exit 1
}

ISUMS="$I"/${SUMS}
# Not using this yet
WSUMS="$W"/${SUMS}

# Update the iTunes SUMS file first
[ "$USE_SUM" ] && {
    cd "$I"
    printf "\nUpdating iTunes SUMS file ...\n"
    [ "$TELL" ] || updsums
}

# Link to file in iTunes library if it's a duplicate
if [ -d "$W" ]
then
    cd "$W"
    # Update the SUMS file if we are using cksums
    [ "$USE_SUM" ] && {
        printf "\nUpdating $W/${SUMS}\n"
        [ "$TELL" ] || updsums
    }
    printf "\nFinding and symlinking duplicate files in $W ...\n"
    FindAndLink
else
    echo "$W does not exist or is not a directory. Skipping."
fi
if [ -d "$M" ]
then
    cd "$M"
    # Update the SUMS file if we are using cksums
    [ "$USE_SUM" ] && {
        printf "\nUpdating $M/${SUMS}\n"
        [ "$TELL" ] || updsums
    }
    printf "\nFinding and symlinking duplicate files in $M ...\n"
    FindAndLink
else
    echo "$M does not exist or is not a directory. Skipping."
fi
if [ -d "$A" ]
then
    cd "$A"
    # Update the SUMS file if we are using cksums
    [ "$USE_SUM" ] && {
        printf "\nUpdating $A/${SUMS}\n"
        [ "$TELL" ] || updsums
    }
    printf "\nFinding and symlinking duplicate files in $A ...\n"
    FindAndLink
else
    echo "$A does not exist or is not a directory. Skipping."
fi

# Create and populate the Femjoy "All" folder
[ "$FEMJOY" ] && {
  if [ -d "$F" ]
  then
    cd "$F"
    printf "\nCreating and populating the Femjoy 'All' folder ...\n"
    [ -d All ] || {
        printf "\nCreating Femjoy All directory\n"
        [ "$TELL" ] || mkdir All
    }
    for d in *
    do
        [ "$d" = "All" ] && continue
        [ -d $d ] && {
            VIDS=`echo */*`
            cd All
            for vid in $VIDS
            do
                Model=`dirname $vid`
                [ "$Model" = "All" ] && continue
                link=`basename $vid`
                [ -L $link ] || {
                    printf "\nln -s ../$vid ."
                    [ "$TELL" ] || ln -s ../$vid .
                }
            done
            cd ..
        }
    done
  else
    echo "$F does not exist or is not a directory. Skipping."
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
if [ -d "$M" ]
then
    cd "$M"
    printf "\nRemoving broken links in $M ...\n"
    FindAndRemove
else
    echo "$M does not exist or is not a directory. Skipping."
fi
if [ -d "$A" ]
then
    cd "$A"
    printf "\nRemoving broken links in $A ...\n"
    FindAndRemove
else
    echo "$A does not exist or is not a directory. Skipping."
fi

echo "Done."
