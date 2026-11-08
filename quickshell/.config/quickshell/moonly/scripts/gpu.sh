#!/usr/bin/env bash

for vendor_file in /sys/class/drm/card[0-9]/device/vendor; do
    vendor=$(cat "$vendor_file")
    card_dir=$(dirname "$vendor_file")

    case "$vendor" in
        0x10de)  # NVIDIA
            info=$(nvidia-smi --query-gpu=name,memory.total --format=csv,noheader,nounits)
            echo "${info//, /|}"
            ;;
        0x1002)  # AMD
            bytes=$(cat "$card_dir/mem_info_vram_total")
            echo "AMD Radeon|$(( bytes / 1024 / 1024 ))"
            ;;
        0x8086)  # Intel: la integrada, se ignora
            ;;
    esac
done