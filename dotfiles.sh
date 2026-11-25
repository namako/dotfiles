#!/usr/bin/env bash
# Link dotfiles into $HOME. Safe to run repeatedly.
# Existing files are moved to ~/.dotfiles_backup/<timestamp>/ before linking.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"

# link <path in repo> [<path under $HOME>]
link() {
    local src="$DOTFILES/$1"
    local dst="$HOME/${2:-$1}"

    if [[ -L "$dst" && "$dst" -ef "$src" ]]; then
        echo "ok      ~/${2:-$1}"
        return
    fi

    mkdir -p "$(dirname "$dst")"
    if [[ -e "$dst" || -L "$dst" ]]; then
        local bak="$BACKUP_DIR/${2:-$1}"
        mkdir -p "$(dirname "$bak")"
        mv "$dst" "$bak"
        echo "backup  ~/${2:-$1} -> $bak"
    fi
    ln -s "$src" "$dst"
    echo "link    ~/${2:-$1}"
}

# Oh My Zsh and its custom plugins
install_oh_my_zsh() {
    local zsh_dir="$HOME/.oh-my-zsh"
    [[ -d "$zsh_dir" ]] || git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$zsh_dir"

    local plugin_dir="$zsh_dir/custom/plugins" repo
    for repo in zsh-users/zsh-autosuggestions zsh-users/zsh-syntax-highlighting zsh-users/zsh-completions; do
        [[ -d "$plugin_dir/${repo#*/}" ]] || git clone --depth=1 "https://github.com/$repo.git" "$plugin_dir/${repo#*/}"
    done
}

install_oh_my_zsh

# zsh
link .zshenv
link .zprofile
link .zshrc

# vim / neovim
link .vimrc
link .config/nvim

# tmux
link .tmux.conf

# Ghostty
link .config/ghostty/config

# herdr (only config.toml; the directory also holds sockets/logs)
link .config/herdr/config.toml

# Karabiner-Elements (link the whole directory as Karabiner recommends)
link .config/karabiner
