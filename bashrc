#
## @file bashrc
## @brief Bash .bashrc file with shell environment setup
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2012-2022, Ronald Joe Record
## @date Written 17-Sep-2012
## @version 2.0.1
##
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# TMP and TEMP are defined in the Windows environment.  Leaving
# them set to the default Windows temporary directory can have
# unexpected consequences.
unset TMP
unset TEMP

# Alternatively, set them to the Cygwin temporary directory
# or to any other tmp directory of your choice
# export TMP=/tmp
# export TEMP=/tmp

# Or use TMPDIR instead
export TMPDIR=/tmp

# If you are running through a proxy service some external programs may need
# to know the proxy setting (e.g. gem). If so, configure and uncomment:
# export http_proxy=http://your.proxy.server.com:3128
# export no_proxy=alpha.wallhaven.cc

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTSIZE=5000
HISTFILESIZE=5000
HISTFILE=~/.bash_history

# ~/.bashrc: executed by bash(1) for non-login shells.
if [ `echo $PATH | grep -c /usr/local/sbin` -ne "1" ]; then
PATH="$PATH:/usr/local/bin:/usr/local/sbin"
fi
if [ `echo $PATH | grep -c /usr/local/go/bin` -ne "1" ]; then
PATH="$PATH:/usr/local/go/bin"
fi
if [ `echo $PATH | grep -c $HOME/go/bin` -ne "1" ]; then
PATH="$PATH:$HOME/go/bin"
fi
if [ `echo $PATH | grep -c /usr/local/swift/bin` -ne "1" ]; then
PATH="$PATH:/usr/local/swift/bin"
fi
if [ `echo $PATH | grep -c $HOME/bin` -ne "1" ]; then
PATH="$PATH:$HOME/bin"
fi
if [ `echo $PATH | grep -c $HOME/.local/bin` -ne "1" ]; then
PATH="$PATH:$HOME/.local/bin"
fi
if [ -d /usr/local/bunsen/bin ]; then
PATH="$PATH:/usr/local/bunsen/bin"
fi
export DISPLAY=:0
export GPU_MAX_ALLOC_PERCENT=100
export GPU_MAX_HEAP_SIZE=100
export GPU_SINGLE_ALLOC_PERCENT=100
export GPU_USE_SYNC_OBJECTS=1
export GPU_FORCE_64BIT_PTR=1
export CUDA_DEVICE_ORDER=PCI_BUS_ID
export KDE_FULL_SESSION=false
export IPFS_PATH=/etc/ipfs

export VISUAL=vim
export EDITOR=$VISUAL

# enable terminal linewrap
setterm -linewrap on 2> /dev/null

# colorize man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESSHISTFILE=-

# see /usr/share/doc/bash/examples/startup-files
# (in the package bash-doc) for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# MEDIAROOT is used by doctorfree's Scripts to identify the media root
export MEDIAROOT=/u

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Functions
#
# Example functions for remote and recursive remote copying.
# This assumes you have setup your SSH keys appropriately.
# Replace "user" with the username you wish to use and "IP" with the IP address
# function ubucp() { scp "$@" user@IP:/path/to/user/tmp;}
# function ubuget() { scp user@IP:/path/to/user/"$@" "$@";}
# function ubugetr() { scp -r user@IP:/path/to/user/"$@" "$@";}
# function ubucpr() { scp -r "$@" user@IP:/path/to/user/tmp/"$@";}
#
# Manually start and stop the Leap Motion daemon and agent
# function start-leap() {
#     RUNNING=`ps -ef | grep "Leap Motion" | grep leapd`
#     [ "$RUNNING" ] || {
#         /Applications/Leap\ Motion.app/Contents/MacOS/leapd > /dev/null 2>&1 &
#         sleep 1
#     }
#     RUNNING=`ps -ef | grep "Leap Motion" | grep -v leapd | grep -v grep`
#     [ "$RUNNING" ] || {
#         open /Applications/Leap\ Motion.app
#     }
# }
# function stop-leap() {
#     RUNNING=`ps -ef | grep "Leap Motion" | grep leapd`
#     [ "$RUNNING" ] && killall leapd
#     RUNNING=`ps -ef | grep "Leap Motion" | grep -v leapd | grep -v grep`
#     [ "$RUNNING" ] && killall Leap\ Motion
# }

glog() {
	setterm -linewrap off 2> /dev/null

	git --no-pager log --all --color=always --graph --abbrev-commit --decorate --date-order \
		--format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' "$@" \
		| sed -E \
			-e 's/\|(\x1b\[[0-9;]*m)+\\(\x1b\[[0-9;]*m)+ /├\1─╮\2/' \
			-e 's/(\x1b\[[0-9;]+m)\|\x1b\[m\1\/\x1b\[m /\1├─╯\x1b\[m/' \
			-e 's/\|(\x1b\[[0-9;]*m)+\\(\x1b\[[0-9;]*m)+/├\1╮\2/' \
			-e 's/(\x1b\[[0-9;]+m)\|\x1b\[m\1\/\x1b\[m/\1├╯\x1b\[m/' \
			-e 's/╮(\x1b\[[0-9;]*m)+\\/╮\1╰╮/' \
			-e 's/╯(\x1b\[[0-9;]*m)+\//╯\1╭╯/' \
			-e 's/(\||\\)\x1b\[m   (\x1b\[[0-9;]*m)/╰╮\2/' \
			-e 's/(\x1b\[[0-9;]*m)\\/\1╮/g' \
			-e 's/(\x1b\[[0-9;]*m)\//\1╯/g' \
			-e 's/^\*|(\x1b\[m )\*/\1⎬/g' \
			-e 's/(\x1b\[[0-9;]*m)\|/\1│/g' \
		| command less -r $([ $# -eq 0 ] && echo "+/[^/]HEAD")

	setterm -linewrap on 2> /dev/null
}

# Source in the iTerm 2 tab function if it exists
if [ -f ~/.tab_bash ]; then
    . ~/.tab_bash
fi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

eval "$(direnv hook bash)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
    xterm) export TERM=xterm-color; color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#myip=`ip addr show | awk '$1 == "inet" && $3 == "brd" { sub (/\/.*/,""); print $2 }' | head -1`
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\] \w:\[\033[00m\] \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u \w: \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

function devcp() { scp "$@" rrecord@10.1.30.250:/home/rrecord/transfers;}
function devget() { scp rrecord@10.1.30.250:/home/rrecord/transfers/"$@" "$@";}
function devgetr() { scp -r rrecord@10.1.30.250:/home/rrecord/transfers/"$@" "$@";}
function devcpr() { scp -r "$@" rrecord@10.1.30.250:/home/rrecord/transfers/"$@";}
function procp() { scp "$@" doctorwhen@XX.X.X.51:/Users/doctorwhen/transfers/ubuntu;}
function proget() { scp doctorwhen@XX.X.X.51:/Users/doctorwhen/transfers/ubuntu/"$@" "$@";}
function progetr() { scp -r doctorwhen@XX.X.X.51:/Users/doctorwhen/transfers/ubuntu/"$@" "$@";}
function procpr() { scp -r "$@" doctorwhen@XX.X.X.51:/Users/doctorwhen/transfers/ubuntu/"$@";}
function mmcp() { scp "$@" pi@XX.X.X.85:/home/pi/transfers;}
function mmget() { scp pi@XX.X.X.85:/home/pi/transfers/"$@" "$@";}
function mmgetr() { scp -r pi@XX.X.X.85:/home/pi/transfers/"$@" "$@";}
function mmcpr() { scp -r "$@" pi@XX.X.X.85:/home/pi/transfers/"$@";}
function aircp() { scp "$@" ronaldrecord@XX.X.X.74:/Users/ronaldrecord/transfers;}
function airget() { scp ronaldrecord@XX.X.X.74:/Users/ronaldrecord/transfers/"$@" "$@";}
function airgetr() { scp -r ronaldrecord@XX.X.X.74:/Users/ronaldrecord/transfers/"$@" "$@";}
function aircpr() { scp -r "$@" ronaldrecord@XX.X.X.74:/Users/ronaldrecord/transfers/"$@";}
function maccp() { scp "$@" rrecord@XX.X.X.44:/Users/rrecord/transfers/ubuntu;}
function macget() { scp rrecord@XX.X.X.44:/Users/rrecord/transfers/ubuntu/"$@" "$@";}
function macgetr() { scp -r rrecord@XX.X.X.44:/Users/rrecord/transfers/ubuntu/"$@" "$@";}
function maccpr() { scp -r "$@" rrecord@XX.X.X.44:/Users/rrecord/transfers/ubuntu/"$@";}
function ethcp() { scp "$@" ethos@XX.X.X.61:/home/ethos/transfers;}
function ethget() { scp ethos@XX.X.X.61:/home/ethos/transfers/"$@" "$@";}
function ethgetr() { scp -r ethos@XX.X.X.61:/home/ethos/transfers/"$@" "$@";}
function ethcpr() { scp -r "$@" ethos@XX.X.X.61:/home/ethos/transfers/"$@";}
function vivcp() { scp "$@" doctorwhen@XX.X.X.62:/home/doctorwhen/transfers;}
function vivget() { scp doctorwhen@XX.X.X.62:/home/doctorwhen/transfers/"$@" "$@";}
function vivgetr() { scp -r doctorwhen@XX.X.X.62:/home/doctorwhen/transfers/"$@" "$@";}
function vivcpr() { scp -r "$@" doctorwhen@XX.X.X.62:/home/doctorwhen/transfers/"$@";}
function doccp() { scp "$@" doctorwhen@XX.X.X.22:/home/doctorwhen/transfers;}
function docget() { scp doctorwhen@XX.X.X.22:/home/doctorwhen/transfers/"$@" "$@";}
function docgetr() { scp -r doctorwhen@XX.X.X.22:/home/doctorwhen/transfers/"$@" "$@";}
function doccpr() { scp -r "$@" doctorwhen@XX.X.X.22:/home/doctorwhen/transfers/"$@";}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# My drfree function
if [ -f /usr/local/share/bash/drfree ]; then
    . /usr/local/share/bash/drfree
fi

#PS1='\@ \u@`/bin/hostname`:`pwd` # '
#if [ -f /var/run/infos/status.file ]; then
#  PS1='\@ \u@`/bin/hostname` $myip [$(cat /var/run/infos/status.file | cut -d":" -f1)] `pwd` # '
#else
#  PS1='\@ \u@`/bin/hostname` $myip  `pwd` # '
#fi
eval "$(direnv hook bash)"
