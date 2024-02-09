#!/bin/bash
show_directory() {
  local index=$1
  local icon=$(get_tmux_option "@catppuccin_directory_icon" "")
  local color=$(get_tmux_option "@catppuccin_directory_color" "$thm_pink")
  local text=$(get_tmux_option "@catppuccin_directory_text" "#{pane_current_path}")

  local module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}
