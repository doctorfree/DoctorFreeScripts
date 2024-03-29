#!/bin/bash
#

usage() {
    printf "\nUsage: mvdown [-e] [-j] [-n] [-y] [-t top_dir] [-w working_dir] model_name"
    printf "\nWhere:"
    printf "\n\t-e indicates use Elite Babes folder"
    printf "\n\t-j indicates use JP Erotica folder"
    printf "\n\t-n indicates tell me what you would do without doing it"
    printf "\n\t-t top_dir sets the top-level directory to use"
    printf "\n\t-w working_dir sets the work directory under top_dir to use"
    printf "\n\tmodel_name specifies a subdirectory containing the model photos to use"
    printf "\n\tNo arguments indicates use the current working directory as destination"
    printf "\n\nSettings with the given command-line options are as follows:"
    printf "\n\ttop_dir=${TOP}"
    printf "\n\tworking_dir=${WDIR}\n"
    exit 1
}

# Which system are we on?
if [ -d /Volumes/Seagate_8TB/Pictures ]
then
    TOP="/Volumes/Seagate_8TB/Pictures/Work"
else
    if [ -d /u/pictures ]
    then
        TOP="/u/pictures"
    else
        echo "Cannot determine top-level photo dir. Exiting."
        exit 1
    fi
fi

# Subfolder under $TOP where model folders are located
WDIR="KindGirls"

EFLAG=
JFLAG=
YFLAG=
TELL=
USAGE=
while getopts ejnt:w:yu flag; do
    case $flag in
        e)
            WDIR="Elite_Babes"
            EFLAG=1
            ;;
        j)
            WDIR="JP_Erotica"
            JFLAG=1
            ;;
        n)
            TELL=1
            ;;
        t)
            TOP="$OPTARG"
            ;;
        w)
            WDIR="$OPTARG"
            ;;
        y)
            YFLAG=1
            ;;
        u)
            USAGE=1
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "$USAGE" ] && usage
[ "$EFLAG" ] && [ "$JFLAG" ] && {
    echo "The -e and -j options are mutually exclusive, use only one."
    usage
}

[ -d ${TOP}/${WDIR} ] || {
    echo "$TOP/$WDIR does not exist or is not a directory. Exiting."
    usage
}

if [ "$1" ]
then
    MODEL=`echo $* | sed -e "s/ /_/g"`
    DEST="${TOP}/${WDIR}/${MODEL}"
else
    DEST=`pwd`
fi
if [ -d ${TOP}/DownThemAll ]
then
    DOWN="${TOP}/DownThemAll"
else
    if [ -d ${HOME}/Pictures/DownThemAll ] || [ -L ${HOME}/Pictures/DownThemAll ]
    then
        DOWN="${HOME}/Pictures/DownThemAll"
    else
        DOWN="${HOME}/Downloads/downthemall"
    fi
fi

[ -d ${DOWN} ] || {
    echo "$DOWN does not exist or is not a directory. Exiting."
    exit 1
}

[ -d ${DEST} ] || {
    if [ "${YFLAG}" ]
    then
        if [ "$TELL" ]
        then
            echo "mkdir -p ${DEST}"
        else
            mkdir -p "${DEST}"
        fi
    else
      printf "\nModel directory $DEST does not exist or is not a directory.\n"
      while true
      do
        read -p "Do you want to create the model directory $MODEL ? (y/n) " yn
        case $yn in
            [Yy]* ) if [ "$TELL" ]
                    then
                        echo "mkdir -p ${DEST}"
                    else
                        mkdir -p "${DEST}"
                    fi
                    break;;
            [Nn]* ) printf "\nExiting.\n"; exit 1;;
                * ) echo "Please answer yes or no.";;
        esac
      done
    fi
}

cd "${DOWN}"
if [ "$TELL" ]
then
    echo "rm -f extlink.png watch"
else
    rm -f extlink.png watch
fi
moved=0
for i in *.jpg
do
    [ "$i" = "*.jpg" ] && {
        echo "No pics. Exiting."
        MOVNUM=`ls -1 "${DEST}" | wc -l`
        [ ${MOVNUM} -gt 0 ] || {
            if [ "$TELL" ]
            then
                echo "rmdir ${DEST}"
            else
                rmdir "${DEST}"
            fi
        }
        exit 1
    }
    [ -r "${DEST}/$i" ] && {
        echo "${DEST}/$i already exists. Skipping."
        [ -d __Skipped__ ] || {
            if [ "$TELL" ]
            then
                echo "mkdir __Skipped__"
            else
                mkdir __Skipped__
            fi
        }
        if [ "$TELL" ]
        then
            echo "mv $i __Skipped__"
        else
            mv "$i" __Skipped__
        fi
        continue
    }
    if [ "$TELL" ]
    then
        echo "cp $i ${DEST} && rm -f $i"
    else
        cp "$i" "${DEST}" && rm -f "$i"
    fi
    moved=`expr $moved + 1`
done
echo "Moved $moved pics to ${DEST}"

[ "$TELL" ] || {
    NUM=`ls -1 | grep -v __Skipped__ | wc -l`

    [ ${NUM} -gt 1 ] && {
        echo ""
        echo "Additional pics: "
        ls -1 | grep -v mvall | grep -v __Skipped__
    }
}
