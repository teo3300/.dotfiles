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
        --ignore-empty-password\
        --indicator-idle-visible\
        --indicator-x-position $posx\
        --indicator-y-position $posy\
        --image $wallpaper\
        --debug
