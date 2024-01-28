#!/bin/bash
#################################################
# Created by SkMag9
# https://github.com/skmag9
# Version 0.0.1
#################################################

###############################
# Read arguments and set flags
###############################
ARGS=$(getopt --options abcdinNtuUzZ --long "inst-conf-all,conf-boot,conf-all,docker-zsh,inst-all,inst-nvim,conf-nvim,inst-utils,update,upgrade,inst-zsh,conf-zsh" -- "$@")

eval set --"$ARGS"

flag_update="false"
flag_upgrade="false"

flag_inst_nvim="false"
flag_inst_nvim_ext="false"
flag_inst_utils="false"
flag_inst_zsh="false"

flag_conf_boot="false"
flag_conf_nvim="false"
flag_conf_zsh="false"
flag_conf_zsh_docker="false"

while true; do
  case "$1" in
    -a|--inst-conf-all)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_nvim="true"
      flag_inst_nvim_ext="true"
      flag_inst_utils="true"
      flag_inst_zsh="true"
      flag_conf_boot="true"
      flag_conf_nvim="true"
      flag_conf_zsh="true"
      shift;;

    -b|--conf-boot)
      flag_conf_boot="true"
      shift;;

    -c|--conf-all)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_nvim_ext="true"
      flag_conf_boot="true"
      flag_conf_nvim="true"
      flag_conf_zsh="true"
      shift;;

    -d|--docker-zsh)
      flag_update="true"
      flag_conf_zsh_docker="true"
      flag_conf_zsh="true"
      shift;;

    -i|--inst-all)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_nvim="true"
      flag_inst_utils="true"
      flag_inst_zsh="true"
      shift;;

    -n|--inst-nvim)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_nvim="true"
      shift;;
      
    -N|--conf-nvim)
      flag_update="true"
      flag_inst_nvim_ext="true"
      flag_conf_nvim="true"
      shift;;

    -t|--inst-utils)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_utils="true"
      shift;;

    -u|--update)
      flag_update="true"
      shift;;

    -U|--upgrade)
      flag_update="true"
      flag_upgrade="true"
      shift;;

    -z|--inst-zsh)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_zsh="true"
      shift;;

    -Z|--conf-zsh) 
      flag_conf_zsh="true"
      shift;;

    --)
      break;;

    *)
      usage_exit
      exit 1;;
  esac
done

###############################
# Functions
###############################

# Utils
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
  # rm -rf 
}

function write_log() {
  echo $(date) "$@" >> ~/skmag9_init.log
}


# Install
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

# Config
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

  chsh -s $(which zsh)
}

function conf_zsh_docker() {
  # Configure Locales since Docker Image does not include them
  sudo apt install locales -y
  sudo printf '%s\n' LANG=en_GB.UTF-8 LC_ALL=C > /etc/default/locale
  sudo echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen
  sudo locale-gen
}

###############################
# Execute
###############################

if [[ "$flag_update" == true ]]; then
  apt_update  
fi

if [[ "$flag_upgrade" == true ]]; then
  apt_update_upgrade
fi

if [[ "$flag_inst_utils" == true ]]; then
  inst_utils
fi

if [[ "$flag_inst_nvim" == true ]]; then
  inst_nvim
fi

if [[ "$flag_inst_zsh" == true ]]; then
  inst_zsh
fi

if [[ "$flag_inst_nvim_ext" == true ]]; then
  inst_zsh_ext
fi

if [[ "$flag_conf_nvim" == true ]]; then
  conf_nvim
fi

if [[ "$flag_conf_zsh_docker" == true ]]; then
  conf_zsh_docker
fi

if [[ "$flag_conf_zsh" == true ]]; then
  conf_zsh
fi

if [[ "$flag_conf_boot" == true ]]; then
  conf_boot
fi





