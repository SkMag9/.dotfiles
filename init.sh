#!/bin/bash
#################################################
# Created by SkMag9
# https://github.com/skmag9
# Version 0.0.1
#################################################

###############################
# Read arguments and set flags
###############################
ARGS=$(getopt --options abcilnNtuUzZ --long "inst-conf-all,conf-boot,conf-all,inst-all,conf-locale,inst-nvim,conf-nvim,inst-utils,update,upgrade,inst-zsh,conf-zsh" -- "$@")

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

    -l|--conf-locale)
      flag_update="true"
      flag_conf_locale="true"
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
  local conf_backup_dir

  conf_backup_dir="$HOME/.conf_backup_$(date +'%Y%m%d%H%M%S')/$backup_dir_name"

  mkdir -p "$conf_backup_dir"
  mv -v "$path_to_dir" "$conf_backup_dir"
  # rm -rf
}

function write_log() {
  echo "$(date) $*" >> "$HOME/skmag9_init.log"
}


# Install
function inst_nvim() {
  # Dependencies
  sudo apt install clang cmake curl file gettext git ninja-build unzip -y

  # Clone Repository
  git clone https://github.com/neovim/neovim "$HOME/neovim"

  # Build NeoVim
  cd "$HOME/neovim" || exit
  git checkout stable
  make CMAKE_BUILD_TYPE=RelWithDebInfo

  # Package & Install NeoVim
  cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

  # Cleanup
  cd "$HOME" && rm -rf "$HOME/neovim"
}

function inst_nvim_ext() {
  # Only being called from conf_nvim at the moment, so apt update is needed
  apt_update_upgrade
  sudo apt install ripgrep gcc -y


  # Install golang
  cd "$HOME" || exit
  wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz
  rm -rf "$HOME/go1.21.6.linux-amd64.tar.gz"



  # Install needed Packages for Formatters, Linters, DAPs and LSPs
  go install mvdan.cc/gofumpt@latest
  go install github.com/segmentio/golines@latest
  go install -v github.com/incu6us/goimports-reviser/v3@latest
}

function inst_utils() {
  # Man Pages
  sudo apt install manpages man-db -y

  # CLI Tools
  sudo apt install curl git gzip jq neofetch tar tree unzip wget -y

  # NTP
  sudo apt install ntpdate -y

  # Languages, Runtimes
  ## Python
  sudo apt install python3 python3-venv -y
}

function inst_zsh() {
  sudo apt install zsh -y
}

# Config
function conf_boot() {
  sudo ln -sf "$HOME/.dotfiles/files/wsl.conf /etc/wsl.conf"
}

function conf_locale() {
  # Configure Locales since Docker Image does not include them
  sudo apt install locales -y
  printf '%s\n' LANG=en_GB.UTF-8 LC_ALL=C | sudo tee /etc/default/locale > /dev/null
  echo "en_GB.UTF-8 UTF-8" | sudo tee /etc/locale.gen > /dev/null
  sudo locale-gen
}

function conf_nvim() {
  inst_nvim_ext

  rm -rf "$HOME/.local/share/nvim"
  rm -rf "$HOME/.config/nvim"

  mkdir -p "$HOME/.config"

  ln -sf "$HOME/.dotfiles/files/.config/nvim/" "$HOME/.config/"
}

function conf_zsh() {
  rm -rf "$HOME/.zshrc"
  rm -rf "$HOME/.histfile"
  rm -rf "$HOME/.config/zsh"

  mkdir -p "$HOME/.config/zsh/theme"

  ln -sf "$HOME/.dotfiles/files/.zshrc" "$HOME/.zshrc"
  ln -sf "$HOME/.dotfiles/files/.config/zsh/theme/theme.zsh" "$HOME/.config/zsh/theme/theme.zsh"

  chsh -s "$(which zsh)"
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

if [[ "$flag_conf_locale" == true ]]; then
  conf_zsh_docker
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
  inst_nvim_ext
fi

if [[ "$flag_conf_zsh" == true ]]; then
  conf_zsh
fi

if [[ "$flag_conf_nvim" == true ]]; then
  conf_nvim
fi

if [[ "$flag_conf_boot" == true ]]; then
  conf_boot
fi





