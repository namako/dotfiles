#!/usr/bin/env bash
# Link dotfiles into $HOME. Safe to run repeatedly.
# Existing files are moved to ~/.dotfiles_backup/<timestamp>.XXXXXX/ before linking;
# if a link cannot be created, the original file is moved back.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="$HOME/.dotfiles_backup"
LOCK_DIR="$BACKUP_ROOT/.lock"

# Paths (relative to the repo and to $HOME) to link
LINKS=(
    # zsh
    .zshenv
    .zprofile
    .zshrc
    # vim / neovim
    .vimrc
    .config/nvim
    # tmux
    .tmux.conf
    # Ghostty
    .config/ghostty/config
    # herdr (only config.toml; the directory also holds sockets/logs)
    .config/herdr/config.toml
    # Karabiner-Elements (link the whole directory as Karabiner recommends)
    .config/karabiner
)

# Check every source up front so nothing is moved aside for a link that would dangle
missing=0
for path in "${LINKS[@]}"; do
    if [[ ! -e "$DOTFILES/$path" ]]; then
        echo "!! missing in repo: $path" >&2
        missing=1
    fi
done
(( missing )) && exit 1

# Only one run at a time (mkdir is atomic; macOS has no flock)
mkdir -p "$BACKUP_ROOT"
if ! mkdir "$LOCK_DIR" 2>/dev/null; then
    echo "!! another dotfiles.sh seems to be running (remove $LOCK_DIR if not)" >&2
    exit 1
fi
BACKUP_DIR="$(mktemp -d "$BACKUP_ROOT/$(date +%Y%m%d-%H%M%S).XXXXXX")"
# Release the lock, and drop the backup dir if nothing was backed up
trap 'rmdir "$LOCK_DIR"; find "$BACKUP_DIR" -depth -type d -empty -delete 2>/dev/null || true' EXIT

# link <path relative to the repo and to $HOME>
link() {
    local src="$DOTFILES/$1"
    local dst="$HOME/$1"
    local bak=""

    if [[ -L "$dst" && "$dst" -ef "$src" ]]; then
        echo "ok      ~/$1"
        return
    fi

    mkdir -p "$(dirname "$dst")"
    if [[ -e "$dst" || -L "$dst" ]]; then
        bak="$BACKUP_DIR/$1"
        mkdir -p "$(dirname "$bak")"
        mv "$dst" "$bak"
        echo "backup  ~/$1 -> $bak"
    fi
    if ! ln -s "$src" "$dst"; then
        echo "!! failed to link ~/$1" >&2
        if [[ -n "$bak" ]]; then
            mv "$bak" "$dst" && echo "restore ~/$1" >&2
        fi
        return 1
    fi
    echo "link    ~/$1"
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

for path in "${LINKS[@]}"; do
    link "$path"
done
