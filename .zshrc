export LANG=ja_JP.utf8
umask 002
# history opt
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups

setopt auto_cd
setopt auto_pushd
# Ignore duplicates to add to pushd
setopt pushd_ignore_dups
# Replace 'cd - ' with 'cd +'
setopt pushd_minus

autoload -U compinit
compinit -u

setopt auto_menu
setopt auto_resume
setopt auto_list
setopt auto_param_keys

setopt list_types
setopt list_packed

# Check spell command
setopt correct
# Check spell all
setopt correct_all

unsetopt promptcr

autoload -U colors
colors

setopt prompt_subst

setopt ignoreeof

setopt no_tify

setopt hist_ignore_dups

setopt complete_aliases

# No beep
setopt no_beep
setopt no_list_beep
setopt no_hist_beep

#local GREEN=$'%{\e[1;32m%}'
#local BLUE=$'%{\e[1;34m%}'
#local DEFAULT=$'%{\e[1;m%}'

#After completion, I can select by cursor key.
zstyle ':completion:*:default' menu select=2

# -----------------------------------------------
# keybind
# -----------------------------------------------
# vim mode or emacs mode
bindkey -v
#bindkey -e

# menuselect
bindkey '^R' history-incremental-pattern-search-backward
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# vim mode customize
bindkey -M viins '\er' history-incremental-pattern-search-forward
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^G'  send-break
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^K'  kill-line
bindkey -M viins '^N'  down-line-or-history
bindkey -M viins '^P'  up-line-or-history
bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank

# -----------------------------------------------
# prompt 
# -----------------------------------------------

#PROMPT=$BLUE'[%n]%# '$WHITE
#RPROMPT=$GREEN'[%~]'$WHITE
setopt transient_rprompt

#PROMPT="%{$terminfo_down_sc$PROMPT_2$terminfo[rc]%}[%(?.%{${fg[green]}%}.%{${fg[red]}%})${HOST}%{${reset_color}%}]%# "
#RPROMPT='[%{$fg[blue]%}%~%{$reset_color%}]'
PROMPT="%{$terminfo_down_sc$PROMPT_2$terminfo[rc]%}[%(?.%{${fg[green]}%}.%{${fg[red]}%})%n%{${reset_color}%}]%# "
RPROMPT='[%{$fg[blue]%}%~%{$reset_color%}]'

export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
#export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
export LS_COLORS='di=36:ln=35:ex=32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

export ZLS_COLORS=$LS_COLORS
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


#for vim mode
autoload -Uz colors; colors
autoload -Uz add-zsh-hook
autoload -Uz terminfo

terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
left_down_prompt_preexec() {
    print -rn -- $terminfo[el]
}
add-zsh-hook preexec left_down_prompt_preexec

function zle-keymap-select zle-line-init zle-line-finish
{
    case $KEYMAP in
        main|viins)
            PROMPT_2="$fg[cyan]-- INSERT --$reset_color"
            ;;
        vicmd)
            PROMPT_2="$fg[white]-- NORMAL --$reset_color"
            ;;
        vivis|vivli)
            PROMPT_2="$fg[yellow]-- VISUAL --$reset_color"
            ;;
    esac

    PROMPT="%{$terminfo_down_sc$PROMPT_2$terminfo[rc]%}[%(?.%{${fg[green]}%}.%{${fg[red]}%})%n%{${reset_color}%}]%# "
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line

# -----------------------------------------------
# functions
# -----------------------------------------------

# auto ls 
function chpwd() { ls }

chpwd() {
    ls_abbrev
}
ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}


