#!/usr/bin/env zsh

# eza in place of ls
if command -v eza > /dev/null; then
  alias ls='eza --icons --group-directories-first --color=always'
  # minimal long list: icons and git status, no permissions/user/size
  alias ll='eza -lh --icons --group-directories-first --git --no-permissions --no-user --no-filesize --time-style=relative'
  alias la='eza -abghHliS --icons --git --color=always'
  alias tree='eza --tree --icons'
fi

alias python='python3'

# aws regions
alias east='export AWS_REGION=us-east-1'
alias west='export AWS_REGION=us-west-2'
alias ohio='export AWS_REGION=us-east-2'

# git
alias amend='git commit --amend'
alias force='git push origin HEAD --force-with-lease'
alias gph='git push origin HEAD'

alias k='kubectl'
