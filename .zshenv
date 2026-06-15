# Read alias settings
if {[ -f ~/dotfiles/.zsh/20_aliases.zsh ]}; then
    source ~/dotfiles/.zsh/20_aliases.zsh
fi

if {[ -f ~/dotfiles/.zsh/10_config.csh ]}; then
    source ~/dotfiles/.zsh/20_aliases.zsh
fi


#export LANG=C
export LANG=ja_JP.utf-8

# Env settings
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

umask 002

