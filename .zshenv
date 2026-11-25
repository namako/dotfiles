# ~/.zshenv
# Read by EVERY zsh (scripts and non-interactive shells too).
# Keep this to environment variables only; aliases and options go in .zshrc.

export LANG=ja_JP.UTF-8

umask 002

# Remove duplicate PATH entries automatically
typeset -U path PATH
path=(
    "$HOME/.local/bin"
    /Applications/klayout.app/Contents/MacOS
    $path
)
