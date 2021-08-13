#!/bin/bash

# set tmux panes for work

if [ "$#" -eq 0 ]; then
    dir=`cat ./tmux_working_dir.txt`
    cd ${dir}
    tmux split-window -v
    tmux split-window -h
    tmux resize-pane -D 15
    tmux select-pane -t 0
else
    dir=$1
    cd ${dir}
    tmux split-window -v
    tmux split-window -h
    tmux resize-pane -D 15
    tmux select-pane -t 0
fi
