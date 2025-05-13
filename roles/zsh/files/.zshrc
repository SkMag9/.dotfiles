# Locales
export LC_ALL="en_GB.UTF-8"
export LANGUAGE="en_GB.UTF-8"
export LANG="en_GB.UTF-8"

# Configs
CASE_SENSITIVE="true"

# History
export HISTFILE=$HOME/.histfile
export HIST_STAMP="yyyy-mm-dd"
export HISTSIZE=1000
export SAVEHIST=5000

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

alias history="history -i 0"

# Line edit behaviour = vim
bindkey -v

# ENV Vars
## Go
export PATH="/usr/local/go/bin:$HOME/go/bin:$HOME/.local/bin:$PATH"

## Ruby
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin/:$PATH"

# Aliases
alias la="ls -alh"
alias ll="ls -alh"
alias l="ls -alh"

alias mkdir="mkdir -p"
alias cp="cp -r"

alias python="/usr/bin/python3"

alias vim="nvim"
alias vi="nvim"
alias v="nvim"

alias waybar-reload="pkill waybar && hyprctl dispatch exec waybar"

alias vd="cd $HOME/.dotfiles && v"
# Plugins

# Theme 
source $HOME/.config/zsh/theme/theme.zsh

