# zinit Plugin Manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Prompt
source "${HOME}/.config/zsh/theme/theme.zsh"

# Install zinit Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Install Snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Configuration
autoload -U compinit && compinit
zinit cdreplay -q

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# History
HISTSIZE=5000
SAVEHIST=5000
HIST_STAMP="yyyy-mm-dd"
HISTFILE=${HOME}/.zsh_history
HISTDUP=erase # Erase Duplicates in history
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybinds
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Aliases
alias ls="ls --color"
alias la="ls -ah"
alias ll="ls -alh"
alias l="ls -alh"

alias vim="nvim"
alias vi="nvim"
alias v="nvim"

alias vd="cd $HOME/.dotfiles && v"

# Shell Integrations
eval "$(fzf --zsh)"
