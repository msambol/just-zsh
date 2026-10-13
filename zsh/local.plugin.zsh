#!/usr/bin/env zsh

ROOTDIR=${${(%):-%N}:A:h}

source "$ROOTDIR/common/init.zsh"
source "$ROOTDIR/direnv/init.zsh"
source "$ROOTDIR/fzf/init.zsh"
source "$ROOTDIR/git/init.zsh"
source "$ROOTDIR/golang/init.zsh"
