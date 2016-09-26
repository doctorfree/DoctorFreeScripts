#
## @file bash_aliases
## @brief Bash .bash_aliases file with convenience command aliases
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2012, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2012
## @version 1.0.1
##
alias c='clear'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ldown='ls -1tr ~/Downloads'
alias df='df -h'
alias du='du -h'
alias dutop='du -h -d 0'
alias whence='type -a'
# Convenience alias to log an entry to my Day One journal
alias log="~/Scripts/logtodayone.rb"
# Project working directories
alias mbs='cd "/Volumes/My_Book_Studio"'
alias mbsa='cd "/Volumes/My_Book_Studio/Audio"'
alias mbsm='cd "/Volumes/My_Book_Studio/Movies/Work"'
alias mbsp='cd "/Volumes/My_Book_Studio/Pictures/Work"'
alias lacie='cd /Volumes/LaCie_4TB'
alias itunes='cd /Volumes/LaCie_4TB/iTunes'
alias transcend='cd /Volumes/Transcend'
# Easily switch between JDK versions
alias setjdk6='export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)'
alias setjdk7='export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
