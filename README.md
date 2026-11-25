# dotfiles

namako's dotfiles for macOS.

- **Shell**: zsh + Oh My Zsh (agnoster), eza / bat aliases
- **Editor**: Neovim (lazy.nvim, nvim-treesitter, nvim-tree, lualine), Vim
- **Terminal**: Ghostty, tmux, herdr
- **Keyboard**: Karabiner-Elements
- **Packages**: Homebrew (`Brewfile`)

## Install

```sh
git clone https://github.com/namako/dotfiles.git ~/dotfiles   # any location works
~/dotfiles/install.sh
```

`install.sh` does the following. It is safe to re-run.

1. Install Homebrew (if missing) and run `brew bundle`
2. Install Oh My Zsh and its plugins
3. Symlink the files below into `$HOME`
   (existing files are moved to `~/.dotfiles_backup/<timestamp>/`)

To only (re)create the symlinks: `./install.sh --no-brew`

## Layout

| Repo | Linked to | Note |
|---|---|---|
| `.zshenv` | `~/.zshenv` | env vars only (read by every zsh) |
| `.zprofile` | `~/.zprofile` | Homebrew |
| `.zshrc` | `~/.zshrc` | Oh My Zsh, options, keybinds |
| `.zsh/20_aliases.zsh` | — | sourced from `.zshrc` |
| `.vimrc` | `~/.vimrc` | |
| `.config/nvim/` | `~/.config/nvim/` | includes `lazy-lock.json` |
| `.tmux.conf` | `~/.tmux.conf` | prefix `C-t` |
| `.config/ghostty/config` | `~/.config/ghostty/config` | |
| `.config/herdr/config.toml` | `~/.config/herdr/config.toml` | |
| `.config/karabiner/` | `~/.config/karabiner/` | whole directory |

## Tips

- **Add a file**: put it in the repo and add a `link` line to `dotfiles.sh`.
- **Update Brewfile**: `brew bundle dump --force --file=Brewfile`
- **Karabiner**: restart Karabiner-Elements after the first link.
