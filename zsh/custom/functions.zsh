#!/usr/bin/env zsh

# Fuzzy z: no args picks a frequent directory with fzf, otherwise behaves like z
unalias z 2>/dev/null
z() {
  if ! command -v _z &>/dev/null; then
    echo "z: _z not loaded"; return 1
  fi
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##* }" | sed 's/^[0-9.]* *//')"
  else
    _z "$@"
  fi
}
