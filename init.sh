#!/bin/bash

usage_exit() {
  echo "Usage: $0 [options]\n"
  echo "\t-a\tInstall everything including configuration"
  echo "\t-b\tLoad configuration of ZSH"
  echo "\t-c\tLoad configuration of NeoVim"
  echo "\t-d\tInstall Dive (Docker Image Inspection Tool)"
  echo "\t-n\tInstall NeoVim"
  echo "\t-u\tInstall utilities (python3, wget, jq, neofetch, tree)"
  echo "\t-z\tInstall Zsh"
}

#./scripts/install/neovim.install.sh
./scripts/install/zsh.install.sh
#./scripts/install/utilities.install.sh
#./scripts/config/neovim.config.sh
#./scripts/config/zsh.config.sh


# TODO
# - [ ] Make Script Options
# - [ ] 

