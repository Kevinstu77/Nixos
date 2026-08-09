#!/usr/bin/env bash
set -euo pipefail
clear

compname=$(hostname)
echo "Configuring for host: $compname"

if [ -f ~/.ssh/id_ed25519 ]; then
  echo "SSH key already exists at ~/.ssh/id_ed25519, skipping generation."
else
  read -p "What is your identifier? " Identifier
  ssh-keygen -t ed25519 -C "$Identifier"
fi

echo ""
echo "Your public key (copy this and add it to GitHub → Settings → SSH keys):"
cat ~/.ssh/id_ed25519.pub

#password
nix-shell -p mkpasswd --run 'mkpasswd -m yescrypt'
cd ~/Nixproject/secrets
nix run github:ryantm/agenix -- -e colbys-password.age
