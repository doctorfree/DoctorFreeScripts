#
## @file bash_aliases
## @brief Bash .bash_aliases file with convenience command aliases
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2012-2022, Ronald Joe Record
## @date Written 17-Sep-2012
## @version 2.0.1
##
alias c='clear'
alias cm='check_miner'
alias tm='tail -f /var/run/miner.output'
alias ldown='ls -1tr ~/Downloads'
alias df='df -h'
alias du='du -h'
alias dutop='du -h -d 0'
alias whence='type -a'
alias open='xdg-open '
alias sudo='sudo '
alias macbook='ssh -l ronaldrecord XX.X.X.74'
alias macmini='ssh -l rrecord XX.X.X.44'
alias macpro='ssh -l doctorwhen XX.X.X.51'
alias pimirror='ssh -l pi XX.X.X.85'
alias pimirrorx='ssh -X -l pi XX.X.X.85'
alias ethos='ssh -l ethos XX.X.X.61'
alias doctorwhen='ssh -l doctorwhen XX.X.X.22'
alias vivo='ssh -l doctorwhen XX.X.X.62'
alias s='show miner'
alias ronrecord='cd /u/ronrecord.com/httpdocs'
alias binance='cd ~/src/trading/profit-trailer/binance'
alias config='cd "/usr/local/MagicMirror/config"'
alias configs='cd "/usr/local/MagicMirror/config"'
alias modules='cd "/usr/local/MagicMirror/modules"'
alias wls='ls /u/pictures/Wallhaven'
alias mls='ls /u/pictures/Wallhaven/Models'
alias pls='ls /u/pictures/Wallhaven/Photographers'
alias gb='get-background'
alias sb='show-background'
alias mb='mkbgfav'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'
    alias pacman='pacman --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

command -v vim > /dev/null && alias vi='vim'
command -v lsd > /dev/null && alias ls='lsd --group-dirs first' && \
	alias tree='lsd --tree'
command -v colorls > /dev/null && alias ls='colorls --sd --gs' && \
	alias tree='colorls --tree'
command -v htop > /dev/null && alias top='htop'
command -v gotop > /dev/null && alias top='gotop -p $([ "$COLOR_SCHEME" = "light" ] && echo "-c default-dark")'
command -v ytop > /dev/null && alias top='ytop -p $([ "$COLOR_SCHEME" = "light" ] && echo "-c default-dark")'
command -v btm > /dev/null && alias top='btm $([ "$COLOR_SCHEME" = "light" ] && echo "--color default-light")'
command -v bashtop > /dev/null && alias top='bashtop'
command -v bpytop > /dev/null && alias top='bpytop'

### CAT & LESS
command -v bat > /dev/null && \
	alias cat='bat --pager=never' && \
	alias less='bat'
# In Debian the command is batcat
command -v batcat > /dev/null && \
	alias bat='batcat' && \
	alias cat='batcat --pager=never' && \
	alias less='batcat'
