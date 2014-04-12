# source in the system bashrc if it exists (do this prior to setting PS1)
if [ -r /etc/bash.bashrc ] ; then
    source /etc/bash.bashrc
fi

if [ -r /etc/bashrc ] ; then
    source /etc/bashrc
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    cygwin|rxvt|xterm-color|xterm-256color) color_prompt=yes
    ;;
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

if [ -x /usr/sbin/scutil ]; then
    H=`/usr/sbin/scutil --get ComputerName`
else
    H=`hostname -s`
fi
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@$H\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@$H:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@$H: \w\a\]$PS1"
    ;;
esac
export PS1

[ -d /opt/local/sbin ] && PATH=/opt/local/sbin:$PATH
[ -d /opt/local/bin ] && PATH=/opt/local/bin:$PATH
[ -d ~/bin ] && PATH=$PATH:~/bin
export PATH

[ -r .p4config ] && export P4CONFIG=.p4config
[ -d /build/toolchain ] && export TCROOT=/build/toolchain

if [ -r ~/.bashrc ]; then
    source ~/.bashrc
fi

# Uncomment to use the Ruby enVironment Manager (rvm)
# if [ -r /usr/local/rvm/scripts/rvm ]; then
#     source /usr/local/rvm/scripts/rvm
# fi
