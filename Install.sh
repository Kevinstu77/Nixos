#!/usr/bin/env bash
#vars
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
#clone github repo
nix-shell -p git --run "git clone https://github.com/Kevinstu77/Nixos.git /tmp/Nixproject"
#Partition with disko
lsblk
read -p "what is the name of your storage device?" storage
sed -i "s/replace this/$storage/g" "$SCRIPT_DIR/utils/disk-config.nix"
