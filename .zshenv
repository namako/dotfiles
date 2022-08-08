export LANG=C
#export LANG=ja_JP.utf8

if {[ -f ~/dotfiles/.zsh/20_aliases.zsh ]}; then
    source ~/dotfiles/.zsh/20_aliases.zsh
fi

. "$HOME/.cargo/env"
