#
## @file progress_bar.sh
## @brief Displays a progress bar and percentage of tasks completed
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2016, Ronald Joe Record, all rights reserved.
## @date Written 23-Sep-2016
## @version 1.0.1
##
## Displays a progress bar and percentage of tasks completed
## Takes two arguments, total number of tasks and number of tasks completed

## @fn progress()
## @brief Displays a progress bar and percentage of tasks completed
## @param param1 Total number of tasks
## @param param2 Number of tasks completed thus far
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

