#!/bin/bash

sudo dnf upgrade -y
sudo dnf install -y ansible-core git 
git clone https://github.com/skmag9/.dotfiles ${HOME}/.dotfiles
cd .dotfiles && ansible-playbook --ask-become-pass main.yml


