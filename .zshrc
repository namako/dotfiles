# ~/.zshrc
# Interactive shell settings (Oh My Zsh + personal settings)

# -----------------------------------------------
# Oh My Zsh
# -----------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"

ZSH_THEME="agnoster"

# zsh-completions is added to fpath instead of plugins (as its README recommends)
fpath+="$ZSH_CUSTOM/plugins/zsh-completions/src"

# zsh-syntax-highlighting must be the last plugin
plugins=(git docker copypath copyfile zsh-autosuggestions zsh-syntax-highlighting)

source "$ZSH/oh-my-zsh.sh"

# -----------------------------------------------
# Options (on top of the Oh My Zsh defaults)
# -----------------------------------------------
# history (HISTFILE / SAVEHIST are set by Oh My Zsh)
setopt hist_ignore_space
setopt hist_ignore_all_dups

# directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

# completion
setopt auto_param_keys
setopt list_packed

# no beep
setopt no_beep
setopt no_list_beep
setopt no_hist_beep

# -----------------------------------------------
# Keybind (emacs mode)
# -----------------------------------------------
bindkey -e
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# -----------------------------------------------
# Aliases (loaded after Oh My Zsh so they win)
# -----------------------------------------------
# Resolve the repo from this file's real path, so the repo can be cloned anywhere
DOTFILES="${${(%):-%x}:A:h}"
[[ -f "$DOTFILES/.zsh/20_aliases.zsh" ]] && source "$DOTFILES/.zsh/20_aliases.zsh"

# -----------------------------------------------
# Auto ls on cd
# -----------------------------------------------
ls_abbrev() {
    local ls_result
    if (( $+commands[eza] )); then
        ls_result=$(command eza -a --grid --width="$COLUMNS" --color=always --icons=auto --group-directories-first .)
    else
        ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command ls -aCFG)
    fi

    local ls_lines=$(print -r -- "$ls_result" | wc -l | tr -d ' ')

    if (( ls_lines > 10 )); then
        print -r -- "$ls_result" | head -n 5
        echo '...'
        print -r -- "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        print -r -- "$ls_result"
    fi
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd ls_abbrev
