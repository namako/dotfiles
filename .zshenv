# Read alias settings
if {[ -f ~/dotfiles/.zsh/20_aliases.zsh ]}; then
    source ~/dotfiles/.zsh/20_aliases.zsh
fi

if {[ -f ~/dotfiles/.zsh/10_config.zsh ]}; then
    source ~/dotfiles/.zsh/10_config.zsh
fi


#export LANG=C
export LANG=ja_JP.utf-8

# Env settings
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin/git:$PATH"
export PATH="/Applications/klayout.app/Contents/MacOS/:$PATH"

umask 002

