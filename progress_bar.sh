# Displays a progress bar and percentage of tasks completed
# Takes two arguments, total number of tasks and number of tasks completed
progress() {
    numd=$1
    comp=$2
    perdone=`echo "$comp/$numd" | bc -l`
    statlen=`echo "($perdone*75)/1" | bc`
    remain=`echo "74-$statlen" | bc`
    percent=`echo "($perdone*100)/1" | bc`
    printf '%0.s#' $(seq 1 $statlen)
    [ $percent -lt 100 ] && printf '%0.s_' $(seq 1 $remain)
    printf " $percent%%"
    printf "\r"
}

