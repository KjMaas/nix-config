#!/usr/bin/env sh

TOGGLEANIMATIONS=$(hyprctl getoption animations:enabled | awk 'NR==2{print $2}')

if [ "$TOGGLEANIMATIONS" = 1 ] ; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:active_opacity 1
        keyword decoration:inactive_opacity 1
        keyword decoration:fullscreen_opacity 1

        keyword decoration:blur 0;\
        keyword general:gaps_in 2;\
        keyword general:gaps_out 5;\
        keyword general:border_size 0;\
        keyword decoration:rounding 0"
    exit
fi

hyprctl reload


