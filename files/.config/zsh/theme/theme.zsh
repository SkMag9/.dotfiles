###### Prompt ######

##### Config #####

#### Prefix ####
# String to append to the left of the prompt.
# Default is a single whitespace to keep it of the screen edge. 
PROMPT_PADDING=" "

#### Colors ####
# The prompt consists of a few blocks that have a background (BG) and a font color (FG).
# You can use hex colors for this but for compatibility and user preference reasons named colors should be used.
# black, red, green, yellow, blue, purple, cyan, white and default
OS_BG="white"
OS_FG="black"

PATH_BG="blue"
PATH_FG="white"

GIT_BG_UNMODIFIED="green"
GIT_FG_UNMODIFIED="black"

GIT_BG_MODIFIED="yellow"
GIT_FG_MODIFIED="black"

#### Icons ####
# Uncomment one of the following lines for the icon you want for the OS.

# Tux
# OS_ICON="\uf17c" 

# Kali Linux
# OS_ICON="\uf327"

# Arch Linux
# OS_ICON="\uf303"

# Debian
OS_ICON="\uf306"

# Ubuntu
# OS_ICON="\uf31b"

# Fedora
# OS_ICON="\uf30a"

# Pop!_OS
# OS_ICON="\uf32a"


##### Helpers #####
zsh_prompt_color_wrapper() {
  # Usage: zsh_prompt_colors background_color font_color text
  # Output: Prompt config with $text surrounded with the backgroundcolor
  echo "%K{$1}%F{$2} %B$3%b %f%k"
}

zsh_prompt_transition() {
  echo "%K{$2}%F{$1}\ue0b0%f%k"
}

##### Prompt blocks definitions #####
#### OS ####
PROMPT_OS="$(zsh_prompt_color_wrapper ${OS_BG} ${OS_FG} ${OS_ICON})"

#### PATH ####
get_path() {
  
  case $PWD in
    $HOME )
      PATH_ICON="\uf015" # House Icon
      ;;
    "$HOME/projects"* ) 
      PATH_ICON="\uf121" # Dev Icon
      ;;
    *)
      PATH_ICON="\uf07b" # Folder Icon
      ;;
  esac
  
  echo "$(zsh_prompt_transition ${OS_BG} ${PATH_BG})$(zsh_prompt_color_wrapper ${PATH_BG} ${PATH_FG} "${PATH_ICON} %~")"
}

#### Git ####
### Base ###
autoload -Uz vcs_info

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr ' \uf067'
zstyle ':vcs_info:git:*' unstagedstr ' \uf128'
zstyle ':vcs_info:git:*' formats '%b%c%u'

### Prompt ###
zsh_prompt_git_prompt() {
  if [[ "${vcs_info_msg_0_}" != "" ]];then
    case ${vcs_info_msg_0_} in
      *"\uf067"*|*"\uf128"*)
        GIT_STATUS_BG="${GIT_BG_MODIFIED}"
	GIT_STATUS_FG="${GIT_FG_MODIFIED}"
        ;;
      *)
        GIT_STATUS_BG="${GIT_BG_UNMODIFIED}"
	GIT_STATUS_FG="${GIT_FG_UNMODIFIED}"
	;;
    esac



    echo "$(zsh_prompt_transition ${PATH_BG} ${GIT_STATUS_BG})$(zsh_prompt_color_wrapper ${GIT_STATUS_BG} ${GIT_STATUS_FG} " \ue725 ${vcs_info_msg_0_} ")$(zsh_prompt_transition ${GIT_STATUS_BG} default)"
  else
    echo "$(zsh_prompt_transition ${PATH_BG} default)"
  fi
}


###### RESULT ######
setopt PROMPT_SUBST
PROMPT='${PROMPT_OS}$(get_path)$(zsh_prompt_git_prompt) '
RPROMPT="$(echo "%K{default}%F{white}\ue0b2%f%k")$(zsh_prompt_color_wrapper white black "%*")"


