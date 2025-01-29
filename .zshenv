# Read alias settings
if {[ -f ~/dotfiles/.zsh/20_aliases.zsh ]}; then
    source ~/dotfiles/.zsh/20_aliases.zsh
fi

. "$HOME/.cargo/env"


#export LANG=C
export LANG=ja_JP.utf8

# Env settings
export PATH=$HOME/.nodebrew/current/bin:$PATH

umask 002

