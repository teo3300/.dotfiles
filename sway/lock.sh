#!/bin/bash

wallpaper=$1

space=$2

size=$(swaymsg -rt get_outputs | jq .[-1].current_mode)
posx=$(($(echo $size | jq .width) - $space))
# posy=$(($(echo $size | jq .height) - $space))
posy=$space
echo $posx, $posy

swaylock\
        -f\
        --clock\
        --ignore-empty-password\
        --timestr "%H:%M"\
        --datestr ""\
        --font-size 30\
        --indicator\
        --indicator-x-position $posx\
        --indicator-y-position $posy\
        --effect-vignette 0.4:0.4\
        --fade-in 0.4\
        --font dejavu-sans-mono\
        --image $wallpaper\
        --debug
