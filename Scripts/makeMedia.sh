#!/usr/bin/env bash
set -euo pipefail

#find iso path
echo "what is the path to your iso?"
read -r isoPath
clear

lsblk
echo "what is the path to your usb?"
read -r usbPath
clear

#Write to usb
sudo dd if="$isoPath" of="$usbPath" bs=4M status=progress oflag=sync
