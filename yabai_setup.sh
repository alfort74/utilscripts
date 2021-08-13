#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "実行するには引数を指定してください。"
    exit 1
else
    case $1 in
        service)
            brew services start skhd
            brew services start yabai
            ;;
        stop)
            brew services stop skhd
            brew services stop yabai
            ;;
        install)
            brew install koekeishiya/formulae/yabai
            brew install koekeishiya/formulae/skhd

            echo """
            #!/usr/bin/env sh

            # global settings
            yabai -m config mouse_follows_focus          on
            yabai -m config focus_follows_mouse          autoraise
            yabai -m config window_placement             second_child
            yabai -m config window_topmost               on
            yabai -m config window_shadow                off
            yabai -m config window_opacity               on
            yabai -m config window_opacity_duration      0.0
            yabai -m config active_window_opacity        1.0
            yabai -m config normal_window_opacity        0.95
            yabai -m config window_border                on
            yabai -m config window_border_width          6
            yabai -m config active_window_border_color   0xff775759
            yabai -m config normal_window_border_color   0xff555555
            yabai -m config insert_feedback_color        0xaad75f5f
            yabai -m config split_ratio                  0.50
            yabai -m config auto_balance                 on
            yabai -m config mouse_modifier               fn
            yabai -m config mouse_action1                move
            yabai -m config mouse_action2                resize

            # general space settings
            yabai -m config layout                       bsp
            yabai -m config top_padding                  12
            yabai -m config bottom_padding               12
            yabai -m config left_padding                 12
            yabai -m config right_padding                12
            yabai -m config window_gap                   06

            # restore position of floating windows when they are manually unfloated
            # ~/Scripts/yabai_restore.sh

            echo "yabai configuration loaded.."
            """ > ~/.yabairc

            echo """

            # focus window
            alt - x : yabai -m window --focus recent
            alt - h : yabai -m window --focus west
            alt - j : yabai -m window --focus south
            alt - k : yabai -m window --focus north
            alt - l : yabai -m window --focus east
            alt - z : yabai -m window --focus stack.prev
            alt - c : yabai -m window --focus stack.next

            # swap window
            shift + alt - x : yabai -m window --swap recent
            shift + alt - h : yabai -m window --swap west
            shift + alt - j : yabai -m window --swap south
            shift + alt - k : yabai -m window --swap north
            shift + alt - l : yabai -m window --swap east

            # move window
            shift + cmd - h : yabai -m window --warp west
            shift + cmd - j : yabai -m window --warp south
            shift + cmd - k : yabai -m window --warp north
            shift + cmd - l : yabai -m window --warp east

            # move window
            shift + ctrl - a : yabai -m window --move rel:-20:0
            shift + ctrl - s : yabai -m window --move rel:0:20
            shift + ctrl - w : yabai -m window --move rel:0:-20
            shift + ctrl - d : yabai -m window --move rel:20:0

            # increase window size
            shift + alt - a : yabai -m window --resize left:-20:0
            shift + alt - s : yabai -m window --resize bottom:0:20
            shift + alt - w : yabai -m window --resize top:0:-20
            shift + alt - d : yabai -m window --resize right:20:0

            # decrease window size
            shift + cmd - a : yabai -m window --resize left:20:0
            shift + cmd - s : yabai -m window --resize bottom:0:-20
            shift + cmd - w : yabai -m window --resize top:0:20
            shift + cmd - d : yabai -m window --resize right:-20:0

            # rotate tree
            alt - r : yabai -m space --rotate 90

            # mirror tree y-axis
            alt - y : yabai -m space --mirror y-axis

            # mirror tree x-axis
            alt - x : yabai -m space --mirror x-axis

            # toggle desktop offset
            alt - a : yabai -m space --toggle padding && yabai -m space --toggle gap

            # toggle window fullscreen zoom
            alt - f : yabai -m window --toggle zoom-fullscreen

            # toggle window native fullscreen
            shift + alt - f : yabai -m window --toggle native-fullscreen

            # toggle window split type
            alt - e : yabai -m window --toggle split

            # float / unfloat window and restore position
            # alt - t : yabai -m window --toggle float && /tmp/yabai-restore/$(yabai -m query --windows --window | jq -re '.id').restore 2>/dev/null || true
            alt - t : yabai -m window --toggle float && yabai -m window --grid 4:4:1:1:2:2
            """ > ~/.skhdrc
        *)
            echo [ERROR] "$1"は設定されていない引数です。
            ;;
        esac
fi

exit 0
