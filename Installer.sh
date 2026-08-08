#!/usr/bin/env bash
clear

#questions
lsblk
echo ""
read -p "What is the name of your storage device?" storage
clear
echo ""
read -p "What is the computer's name?" compname
clear
echo ""
read -p "What is your user name?" username
clear
echo ""
read -p "What will your temp password be?" tempass

#vars
TARGET_DIR="/mnt/home/$username/Nixproject"
TMP_DIR="/tmp/Nixproject"

#Clone github repo
echo "cloning repo..."
nix-shell -p git --run "git clone https://github.com/Kevinstu77/Nixos.git $TMP_DIR"

#Partition the disk
sed -i "s/replace this/$storage/g" "$TMP_DIR/utils/disk-config.nix"
echo "disk is being partitioned..."
sudo nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko $TMP_DIR/utils/disk-config.nix
nix-shell -p git --run "git clone https://github.com/Kevinstu77/Nixos.git $TARGET_DIR"

#Host folder
echo "generating entrey in host folder..."
mkdir -p "$TARGET_DIR/Hosts/$compname/"

#hardware config
echo "generating hardware config..."
nixos-generate-config --root /mnt
cp "/mnt/etc/nixos/hardware-configuration.nix" "$TARGET_DIR/Hosts/$compname/"

#Main config
echo "generating main config..."
cp "$TARGET_DIR/Templates/configuration.nix" "$TARGET_DIR/Hosts/$compname/"
sed -i "s/hostNameVar/$compname/g" "$TARGET_DIR/Hosts/$compname/configuration.nix"
sed -i "s/tempPassVar/$tempass/g" "$TARGET_DIR/Hosts/$compname/configuration.nix"
sed -i "s/userNameVar/$username/g" "$TARGET_DIR/Hosts/$compname/configuration.nix"

#change who owns the nix-setup
echo "Fixing file permissions..."
chown -R 1000:100 "$TARGET_DIR"

# Tell git that root is allowed to read this repo during install
sudo git config --global --add safe.directory "$TARGET_DIR"

#Final install
git -C "$TARGET_DIR" add .
sudo nixos-install --root /mnt --flake "$TARGET_DIR#$compname"


echo "Installation done yay"

