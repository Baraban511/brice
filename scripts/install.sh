#!/run/current-system/sw/bin/bash

### Generate hardware configuration
sudo nixos-generate-config --dir /home/barab/brice/nixos/hosts/default


### Copy private key
read -rp "Private key directory: " key_dir
if [ -z "$key_dir" ]; then
    echo "No directory provided."
    exit 1
fi
mkdir -p /home/barab/.ssh
cp $key_dir /home/barab/.ssh/age_ed25519


### Set default wallpaper
rm -r /home/barab/.config/brice
mkdir -p /home/barab/.config/brice
cp /home/barab/brice/assets/wallpaper.jpg /home/barab/.config/brice/unsplash.jpg

### Make changes available for nix
git add .
sudo nixos-rebuild switch --flake /home/barab/brice/nixos#default
