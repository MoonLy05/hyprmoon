#!/usr/bin/env bash

JSON=$(hyprctl clients -j)

for ADDR in $(echo "$JSON" | jq -r '.[] | select(.workspace.id > 5) | .address'); do
    hyprctl dispatch "hl.dsp.window.move({ workspace = \"5\", window = \"address:$ADDR\", follow = false })"
done