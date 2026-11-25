# .zsh/20_aliases.zsh
# Sourced from .zshrc (interactive shells only).

################################################
# COMMON
################################################
alias ls='eza --icons=auto --group-directories-first'
alias la='eza --icons=auto -AF'
alias ll='eza --icons=auto --group-directories-first --git -la'
alias ld='eza --icons=auto -ld'
alias lx='eza --icons=auto -lXB'
alias lk='eza --icons=auto -lSr'
alias lc='eza --icons=auto -ltcr'
alias lu='eza --icons=auto -ltur'
alias lt='eza --icons=auto --tree --level=2'
alias lr='eza --icons=auto -lR'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias rm='rm -i'
alias cp='cp -i'
alias grep='grep --color=auto'
alias less='less -N -x 4'
alias a='./a.out'
alias h='history 25'

alias dirs='dirs -v'

################################################
# Application
################################################
alias vi=nvim
alias python=python3
alias d=less
alias cat=bat
