## namako's dotfiles

The dotfiles include settings for the following applications.

- zsh (Oh My Zsh)
- vim / neovim
- tmux
- Ghostty
- herdr
- Karabiner-Elements

## Setup

```sh
git clone https://github.com/namako/dotfiles.git ~/dotfiles   # any location works
~/dotfiles/install.sh
```

`install.sh` installs Homebrew (if missing), runs `brew bundle`, then calls
`dotfiles.sh`, which installs Oh My Zsh + plugins and creates the symlinks.
Existing files are moved to `~/.dotfiles_backup/<timestamp>/`.

- Symlinks only: `./install.sh --no-brew` (or `./dotfiles.sh`)
- Add a new file: put it in the repo and add a `link` line to `dotfiles.sh`

The script is idempotent, so it can be re-run at any time.

## Files

| Repo | Linked to |
|---|---|
| `.zshenv` | `~/.zshenv` (env vars only, read by every zsh) |
| `.zprofile` | `~/.zprofile` (Homebrew) |
| `.zshrc` | `~/.zshrc` (Oh My Zsh, options, keybinds) |
| `.zsh/20_aliases.zsh` | sourced from `.zshrc` |
| `.vimrc` | `~/.vimrc` |
| `.config/nvim/` | `~/.config/nvim/` (includes `lazy-lock.json`) |
| `.tmux.conf` | `~/.tmux.conf` |
| `.config/ghostty/config` | `~/.config/ghostty/config` |
| `.config/herdr/config.toml` | `~/.config/herdr/config.toml` |
| `.config/karabiner/` | `~/.config/karabiner/` |
