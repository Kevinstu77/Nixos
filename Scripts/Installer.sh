#!/usr/bin/env bash
set -euo pipefail
clear

#questions
lsblk

echo "What is the name of your storage device?"
read -r storage

echo "How much ram does the computer have? (GB)"
read -r ram
swap_gb=$((ram + 2))

echo "What is the computer's name?"
read -r compname

echo "What is your user name?"
read -r username


echo "What will your temp password be?"
read -r tempass

#vars
TARGET_DIR="/mnt/home/$username/Nixproject"
TMP_DIR="/tmp/Nixproject"

#Clone github repo
echo "cloning repo..."
rm -rf "$TMP_DIR"
nix-shell -p git --run "git clone https://github.com/Kevinstu77/Nixos.git $TMP_DIR"

#Partition the disk
echo "⚠️  This will COMPLETELY WIPE $storage — all data will be lost."
read -p "Type 'yes' to continue: " confirm
[ "$confirm" = "yes" ] || { echo "Aborted."; exit 1; }

sed -i "s/replace this/$storage/g" "$TMP_DIR/utils/disk-config.nix"
sed -i "s/swapSizeVar/${swap_gb}G/g" "$TMP_DIR/utils/disk-config.nix"
echo "disk is being partitioned..."
sudo nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko "$TMP_DIR/utils/disk-config.nix"
sudo mkdir -p "/mnt/home/$username"
sudo chown "$(id -u):$(id -g)" "/mnt/home/$username"
nix-shell -p git --run "git clone https://github.com/Kevinstu77/Nixos.git $TARGET_DIR"

#Host folder
echo "generating entrey in host folder..."
mkdir -p "$TARGET_DIR/Hosts/$compname/"
cp "$TMP_DIR/utils/disk-config.nix" "$TARGET_DIR/Hosts/$compname/disk-config.nix"

#hardware config
echo "generating hardware config..."
sudo nixos-generate-config --root /mnt
cp "/mnt/etc/nixos/hardware-configuration.nix" "$TARGET_DIR/Hosts/$compname/"

#Main config
echo "generating main config..."
cp "$TARGET_DIR/Templates/configuration.nix" "$TARGET_DIR/Hosts/$compname/"
sed -i "s/hostNameVar/$compname/g" "$TARGET_DIR/Hosts/$compname/configuration.nix"
sed -i "s/tempPassVar/$tempass/g" "$TARGET_DIR/Hosts/$compname/configuration.nix"
sed -i "s/userNameVar/$username/g" "$TARGET_DIR/Hosts/$compname/configuration.nix"

#change who owns the nix-setup
echo "Fixing file permissions..."
sudo chown -R 1000:100 "$TARGET_DIR"

# Tell git that root is allowed to read this repo during install
sudo git config --global --add safe.directory "$TARGET_DIR"

#Final install
git -C "$TARGET_DIR" add .
sudo nixos-install --root /mnt --flake "$TARGET_DIR#$compname"


echo ""
echo "✅ Installation done!"
echo "After rebooting and logging in as $username, run:"
echo "  cd ~/Nixproject && git add . && git commit -m 'add $compname host' && git push"
echo ""
echo "Once SSH is up, also grab this host's key for agenix:"
echo "  cat /etc/ssh/ssh_host_ed25519_key.pub"
