#!/usr/bin/env bash
clear

#Detect computer name
compname=$(hostname)
echo "Configuring for host: $compname"

#generate SSH key
read -p "What is your identifier?" Identifier
ssh-keygen -t ed25519 -C "$Identifier"

#login to github
gh auth login
gh ssh-key add ~/.ssh/id_ed25519.pub --title "$(hostname)-key"


#Push to github
cd ~/Nixproject || exit 1
git add .
git commit -m "Post-install update for $compname"
git push origin main

