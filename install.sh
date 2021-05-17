#!/bin/bash

#link dotfiles 
ABS_PATH=`cd "$1"; pwd`

rm ~/.tmux.conf
ln -sv $ABS_PATH/dots/.tmux.conf ~/.tmux.conf
