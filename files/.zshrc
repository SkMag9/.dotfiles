# Locales
export LC_ALL=en_GB.UTF-8

# run ntp
sudo ntpdate ch.pool.ntp.org >> ~/.ntp_history

# Configs
CASE_SENSITIVE="true"

# History
export HISTFILE=~/.histfile
export HIST_STAMP="yyyy-mm-dd"
export HISTSIZE=1000
export SAVEHIST=5000

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

alias history="history -i"

# Line edit behaviour = vim
bindkey -v

# ENV Vars
export PATH=$PATH:/usr/local/go/bin

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

# Plugins

# Theme 
source ~/.config/zsh/theme/theme.zsh

