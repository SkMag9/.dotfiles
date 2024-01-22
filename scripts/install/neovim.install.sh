#!/bin/bash

cd

# nvim dependencies
sudo apt install clang file ninja-build gettext cmake unzip curl -y

# nvim download
git clone https://github.com/neovim/neovim

# build nvim
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo

cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

cd && rm -rf ~/neovim
