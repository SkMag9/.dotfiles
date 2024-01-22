#!/bin/bash

sudo apt install zsh -y

sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k/powerlevel10k.git ~/powerlevel10k
