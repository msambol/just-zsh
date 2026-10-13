#!/usr/bin/env zsh

# Personal overrides. Loaded last so these win over the defaults in the other modules.

# fzf look & feel
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --margin=1 --padding=1 \
--color=bg+:-1,fg:gray,fg+:white,border:blue,prompt:magenta,hl:cyan,header:green,pointer:red,marker:yellow"

if command -v fd > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# eza colors: directories blue, symlinks cyan, executables magenta
export EZA_COLORS="di=34:ln=36:ex=35:fi=0:mm=32:bd=31:cd=31:su=33:sg=33:tw=34:ow=34"

CUR=${${(%):-%N}:A:h}
source "$CUR/functions.zsh"
source "$CUR/aliases.zsh"
