#!/bin/bash
#################################################
# Created by SkMag9
# https://github.com/skmag9
# Version 0.0.1
#################################################

LC_ALL="en_GB.UTF-8"
LANG="en_GB.UTF-8"
LANGUAGE="en_GB.UTF-8"

# Versions

GO_VERSION="1.24.2"
HELMFILE_VERSION="0.171.0"

###############################
# Read arguments and set flags
###############################
ARGS=$(getopt --options abcGijlmMnNtTuUzZ --long "inst-conf-all,conf-boot,conf-all,conf-gitconfig,inst-all,inst-jekyll,conf-locale,inst-tmux,conf-tmux,inst-nvim,conf-nvim,inst-utils,inst-iac-utils,update,upgrade,inst-zsh,conf-zsh" -- "$@")

eval set --"$ARGS"

flag_update="false"
flag_upgrade="false"

flag_inst_nvim="false"
flag_inst_nvim_ext="false"
flag_inst_tmux="false"
flag_inst_utils="false"
flag_inst_iac_utils="false"
flag_inst_jekyll="false"
flag_inst_zsh="false"
flag_conf_boot="false"
flag_conf_gitconfig="true"
flag_conf_locale="false"
flag_conf_nvim="false"
flag_conf_tmux="false"
flag_conf_zsh="false"

while true; do
  case "$1" in
    -a | --inst-conf-all)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_nvim="true"
      flag_inst_nvim_ext="true"
      flag_inst_tmux="true"
      flag_inst_utils="true"
      flag_inst_iac_utils="true"
      # flag_inst_jekyll="true"
      flag_inst_zsh="true"
      flag_conf_boot="true"
      flag_conf_locale="true"
      flag_conf_gitconfig="true"
      flag_conf_nvim="true"
      flag_conf_tmux="true"
      flag_conf_zsh="true"
      shift
      ;;

    -b | --conf-boot)
      flag_conf_boot="true"
      shift
      ;;

    -c | --conf-all)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_nvim_ext="true"
      flag_conf_boot="true"
      flag_conf_locale="true"
      flag_conf_gitconfig="true"
      flag_conf_nvim="true"
      flag_conf_tmux="true"
      flag_conf_zsh="true"
      shift
      ;;

    -l | --conf-locale)
      flag_update="true"
      flag_conf_locale="true"
      shift
      ;;

    -i | --inst-all)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_nvim="true"
      flag_inst_iac_utils="true"
      flag_inst_tmux="true"
      flag_inst_utils="true"
      flag_inst_zsh="true"
      # flag_inst_jekyll="true"
      shift
      ;;

    -j | --inst-jekyll)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_jekyll="true"
      shift
      ;;

    -G | --gitconfig)
      flag_conf_gitconfig="true"
      shift
      ;;

    -m | --inst-tmux)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_tmux="true"
      shift
      ;;
    -M | --conf-tmux)
      flag_conf_tmux="true"
      shift
      ;;

    -n | --inst-nvim)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_nvim="true"
      shift
      ;;

    -N | --conf-nvim)
      flag_update="true"
      flag_inst_nvim_ext="true"
      flag_conf_nvim="true"
      shift
      ;;

    -t | --inst-utils)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_utils="true"
      shift
      ;;

    -T | --inst-iac-utils)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_iac_utils="true"
      shift
      ;;

    -u | --update)
      flag_update="true"
      shift
      ;;

    -U | --upgrade)
      flag_update="true"
      flag_upgrade="true"
      shift
      ;;

    -z | --inst-zsh)
      flag_update="true"
      flag_upgrade="true"
      flag_inst_zsh="true"
      shift
      ;;

    -Z | --conf-zsh)
      flag_conf_zsh="true"
      shift
      ;;

    --)
      break
      ;;

    *)
      usage_exit
      exit 1
      ;;
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
  echo "$(date) $*" >>"$HOME/skmag9_init.log"
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
  cd build && cpack -G DEB && sudo dpkg -i nvim-linux-x86_64.deb

  # Cleanup
  cd "$HOME" && rm -rf "$HOME/neovim"
}

function inst_nvim_ext() {
  # Only being called from conf_nvim at the moment, so apt update is needed
  apt_update_upgrade
  sudo apt install npm ripgrep gcc -y

  # Install Newer Version of node
  sudo npm install -g n
  sudo n stable

  # Install golang
  cd "$HOME" || exit
  wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
  rm -rf "$HOME/go${GO_VERSION}.linux-amd64.tar.gz"

  PATH="/usr/local/go/bin:$HOME/go/bin:$PATH"

  # Install needed Packages for Formatters, Linters, DAPs and LSPs
  go install mvdan.cc/gofumpt@latest
  go install github.com/segmentio/golines@latest
  go install -v github.com/incu6us/goimports-reviser/v3@latest

  # Trivy
  sudo apt install wget apt-transport-https gnupg lsb-release -y
  wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg >/dev/null
  echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list
  sudo apt update
  sudo apt install trivy -y
}

function inst_tmux() {
  sudo apt install tmux -y
}

function inst_utils() {
  # Man Pages
  sudo apt install manpages man-db -y

  # CLI Tools
  sudo apt install curl git gzip jq neofetch tar tree unzip wget -y

  # NTP
  sudo apt install ntp -y

  # Languages, Runtimes
  ## Python
  sudo apt install python3 python3-venv -y
}

function inst_iac_utils() {
  # Terraform
  if ! command -v terraform &>/dev/null; then
    sudo apt install gnupg software-properties-common curl -y
    wget -O- https://apt.releases.hashicorp.com/gpg \
      | gpg --dearmor \
      | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
      | sudo tee /etc/apt/sources.list.d/hashicorp.list

    sudo apt update
    sudo apt install terraform -y
  else
    sudo apt install --only-upgrade terraform -y
  fi

  # OpenTofu
  if ! command -v tofu &>/dev/null; then
    sudo apt install apt-transport-https ca-certificates curl gnupg -y

    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://get.opentofu.org/opentofu.gpg | sudo tee /etc/apt/keyrings/opentofu.gpg >/dev/null
    curl -fsSL https://packages.opentofu.org/opentofu/tofu/gpgkey | sudo gpg --no-tty --batch --dearmor -o /etc/apt/keyrings/opentofu-repo.gpg >/dev/null
    sudo chmod a+r /etc/apt/keyrings/opentofu.gpg

    echo \
      "deb [signed-by=/etc/apt/keyrings/opentofu.gpg,/etc/apt/keyrings/opentofu-repo.gpg] https://packages.opentofu.org/opentofu/tofu/any/ any main
deb-src [signed-by=/etc/apt/keyrings/opentofu.gpg,/etc/apt/keyrings/opentofu-repo.gpg] https://packages.opentofu.org/opentofu/tofu/any/ any main" \
      | sudo tee /etc/apt/sources.list.d/opentofu.list >/dev/null

    sudo apt update
    sudo apt install tofu -y
  else
    sudo apt install --only-upgrade tofu -y
  fi

  # Helm
  if ! command -v helm &>/dev/null; then
    curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg >/dev/null
    sudo apt-get install apt-transport-https --yes
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

    sudo apt-get update
    sudo apt-get install helm
  else
    sudo apt install --only-upgrade helm -y
  fi

  # Helmfile
  if ! command -v helmfile &>/dev/null; then
    cd "$HOME" || exit
    wget https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_${HELMFILE_VERSION}_linux_amd64.tar.gz
    sudo rm -rf /usr/local/bin/helmfile && sudo tar -C /usr/local/bin -xzf helmfile_${HELMFILE_VERSION}_linux_amd64.tar.gz helmfile

    rm -rf "$HOME/helmfile_${HELMFILE_VERSION}_linux_amd64.tar.gz"
  fi

  # kubectl
  if ! command -v kubectl &>/dev/null; then

    cd "$HOME" || exit
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    sudo rm -rf "$HOME/kubectl"
  fi
}

function inst_jekyll() {
  sudo apt-get install ruby-full build-essential

  # shellcheck disable=2034
  GEM_HOME="$HOME/gems"
  PATH="$HOME/gems/bin:$PATH"

  gem install jekyll bundler
}

function inst_zsh() {
  sudo apt install zsh -y
}

# Config
function conf_boot() {
  sudo ln -sf "$HOME/.dotfiles/files/wsl.conf" "/etc/wsl.conf"
}

function conf_gitconfig() {
  cd "$HOME/.dotfiles" || exit
  git config user.name "SkMag9"
  git config user.email "79118346+SkMag9@users.noreply.github.com"
}

function conf_locale() {
  # Configure Locales since Docker Image does not include them
  sudo apt install locales -y
  printf '%s\n' LANG=en_GB.UTF-8 LC_ALL=C | sudo tee /etc/default/locale >/dev/null
  echo "en_GB.UTF-8 UTF-8" | sudo tee /etc/locale.gen >/dev/null
  sudo locale-gen
}

function conf_nvim() {
  rm -rf "$HOME/.local/share/nvim"
  rm -rf "$HOME/.config/nvim"

  mkdir -p "$HOME/.config/"

  ln -sf "$HOME/.dotfiles/files/.config/nvim/" "$HOME/.config/"
}

function conf_tmux() {
  rm -rf "$HOME/.config/tmux"

  mkdir -p "$HOME/.config/"

  ln -sf "$HOME/.dotfiles/files/.config/tmux/" "$HOME/.config/"
}

function conf_zsh() {
  sudo apt install figlet lolcat -y
  
  rm -rf "$HOME/.zshrc"
  rm -rf "$HOME/.histfile"
  rm -rf "$HOME/.config/zsh"

  mkdir -p "$HOME/.config/"

  ln -sf "$HOME/.dotfiles/files/.zshrc" "$HOME/.zshrc"
  ln -sf "$HOME/.dotfiles/files/.config/zsh/" "$HOME/.config/"

  chmod +x $HOME/.config/zsh/motd.sh

  sudo chsh -s "$(which zsh)" skmag9
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
  conf_locale
fi

if [[ "$flag_inst_utils" == true ]]; then
  inst_utils
fi

if [[ "$flag_inst_tmux" == true ]]; then
  inst_tmux
fi

if [[ "$flag_inst_nvim" == true ]]; then
  inst_nvim
fi

if [[ "$flag_inst_zsh" == true ]]; then
  inst_zsh
fi

if [[ "$flag_conf_zsh" == true ]]; then
  conf_zsh
fi

if [[ "$flag_conf_tmux" == true ]]; then
  conf_tmux
fi

if [[ "$flag_inst_iac_utils" == true ]]; then
  inst_iac_utils
fi

if [[ "$flag_inst_nvim_ext" == true ]]; then
  inst_nvim_ext
fi

if [[ "$flag_conf_gitconfig" == true ]]; then
  conf_gitconfig
fi

if [[ "$flag_conf_nvim" == true ]]; then
  conf_nvim
fi

if [[ "$flag_conf_boot" == true ]]; then
  conf_boot
fi

if [[ "$flag_inst_jekyll" == true ]]; then
  inst_jekyll
fi
