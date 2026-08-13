#!/usr/bin/env sh

# On this panel, brightnessctl's reported 100% is dimmer than 98% (the true
# max), so clamp all adjustments to 98% instead of letting them reach 100%.
MAX=98
DELTA="$1"
shift

CURRENT=$(brightnessctl "$@" -m | cut -d, -f4 | tr -d '%')
NEW=$((CURRENT + DELTA))

[ "$NEW" -gt "$MAX" ] && NEW=$MAX
[ "$NEW" -lt 0 ] && NEW=0

brightnessctl "$@" set "${NEW}%"
