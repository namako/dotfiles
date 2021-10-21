# .zsh/20_aliases.zsh
# Takuya Usami
# ver. 20171127

export LANG=C


################################################
# COMMON
################################################
# Common aliases
alias ls='ls --color'
alias la='ls -AF'
alias ll='ls -lA'
alias ld='ls -ld'
alias lx='ls -lXB'
alias lk='ls -lSr'
alias lc='ls -ltcr'
alias lu='ls -ltur'
alias lt='ls -ltr'
alias lr='ls -lR'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias rm='rm -i'
alias cp='cp -i'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias less='less -N -x 4'
alias a='./a.out'
alias h='history 25'

alias dirs='dirs -v'


################################################
# Applicaton
################################################

alias vi=vim
alias gvi=gvim

alias python=python3
