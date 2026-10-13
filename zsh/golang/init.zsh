#!/usr/bin/env zsh

CUR=${${(%):-%N}:A:h}
# source "$CUR/functions.zsh"
# source "$CUR/aliases.zsh"

export GOPATH="$HOME"
export PATH="$PATH:$GOPATH/bin"
