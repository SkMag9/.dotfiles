#!/bin/bash

# ~/.zshrc
if ! [[ -L ~/.zshrc ]] && [[ -e ~/.zshrc ]]
then
  mv ~/.zshrc ~/.zshrc.bak
fi

ln -sf ~/.dotfiles/files/.zshrc ~/.zshrc

# ~/.config/zsh/themes/theme.zsh
mkdir -p ~/.config/zsh/theme

if ! [[ -L ~/.config/zsh/theme/theme.zsh ]] && [[ -e ~/.config/zsh/theme/theme.zsh ]]
then
  mv ~/.config/zsh/theme/theme.zsh ~/.config/zsh/theme/theme.zsh.bak
fi

ln -sf ~/.dotfiles/files/.config/zsh/theme/theme.zsh ~/.config/zsh/theme/theme.zsh
