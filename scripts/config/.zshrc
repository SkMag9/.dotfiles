# Configs
CASE_SENSITIVE="true"

# History
HISTFILE=~/.histfile
HIST_STAMPS="yyy-mm-dd"
HISTSIZE=1000
SAVEHIST=5000

# Line edit behaviour = vim
bindkey -v

# Oh My ZSH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=()
source $ZSH/oh-my-zsh.sh

# Path
export PATH=$PATH:/usr/local/go/bin

# ENV Vars
#

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


