#!/bin/bash
# Functions
###############################
# Common Patterns:
# inst_<name>() = Functions used to install tools
# conf_<name>() = Functions used to configure tools
###############################
## Util Functions
function apt_update() {
  sudo apt update
}

function apt_update_upgrade() {
  apt_update
  sudo apt upgrade -y
}

function backup_config() {
  # Creates a .tar.gz file with current config

  # Clean Up Existing Config
  local path_to_dir="$1"
  local backup_dir_name="$2"
  local conf_backup_dir="~/.conf_backup_$(date +"%Y%m%d%H%M%S")/$backup_dir_name"

  mkdir -p $conf_backup_dir
  mv -v $path_to_dir $conf_backup_dir
  # rm -rf $
}

function write_log() {
  echo $(date) "$@" >> ~/skmag9_init.log
}

## Base Install Functions
function inst_nvim() {
  # Dependencies
  sudo apt install clang cmake curl file gettext git ninja-build unzip -y

  # Clone Repository
  git clone https://github.com/neovim/neovim ~/neovim 
  
  # Build NeoVim
  cd ~/neovim
  git checkout stable
  make CMAKE_BUILD_TYPE=RelWithDebInfo

  # Package & Install NeoVim
  cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

  # Cleanup
  cd ~ && rm -rf ~/neovim
}

function inst_nvim_ext() {
  # Only being called from conf_nvim at the moment, so apt update is needed
  apt_update_upgrade
  sudo apt install ripgrep gcc -y
}

function inst_utils() {
  # Man Pages
  sudo apt install manpages man-db -y
  
  # CLI Tools
  sudo apt install jq neofetch tree wget -y
 
  # NTP
  sudo apt install ntpdate -y

  # Languages, Runtimes
  ## Python
  sudo apt install python3 -y
}

function inst_zsh() {
  sudo apt install zsh -y
}

## Base Config Functions
function conf_boot() {
  sudo ln -sf ~/.dotfiles/files/wsl.conf /etc/wsl.conf  
}

function conf_nvim() {
  inst_nvim_ext
    
  rm -rf ~/.local/share/nvim
  rm -rf ~/.config/nvim

  mkdir -p ~/.config

  ln -sf ~/.dotfiles/files/.config/nvim/ ~/.config/
}

function conf_zsh() {
  rm -rf ~/.zshrc
  rm -rf ~/.histfile
  rm -rf ~/.config/zsh

  mkdir -p ~/.config/zsh/theme

  ln -sf ~/.dotfiles/files/.zshrc ~/.zshrc
  ln -sf ~/.dotfiles/files/.config/zsh/theme/theme.zsh ~/.config/zsh/theme/theme.zsh

  csh -s $(which zsh)
}

## _all functions tools
function inst_all() {
  inst_utils
  inst_zsh
  inst_nvim
}

function conf_all() {
  conf_zsh
  conf_nvim
}

function inst_conf_all() {
  inst_all
  conf_all
}

# Flags Handling
while getopts 'abcdilnptuz' OPTION; do
  case "$OPTION" in 
    a)
      apt_update_upgrade
      inst_conf_all
      ;;
    b)
      conf_boot
      ;;
    c)
      conf_all
      ;;
    d)
      apt_update_upgrade
      ;;
    i)
      apt_update_upgrade
      inst_all
      ;;
    l)
      conf_nvim
      ;;
    n)
      apt_update_upgrade
      inst_nvim
      ;;
    p)
      apt_update_update
      ;;
    t)
      conf_zsh
      ;;
    u)
      apt_update_upgrade
      inst_utils
      ;;
    z)
      apt_update_upgrade
      inst_zsh
      ;;
  esac
done
