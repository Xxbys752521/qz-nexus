#!/bin/bash

# QZ Server Deployment Script
# Targets: CachyOS / Arch Linux

set -e

echo "🚀 Starting QZ Server environment deployment..."

# 1. Install Paru (AUR Helper) if not exists
if ! command -v paru &> /dev/null; then
    echo "📦 Installing paru..."
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru && makepkg -si --noconfirm
    cd -
fi

# 2. Synchronize Packages
echo "📥 Syncing packages..."
paru -S --needed --noconfirm - < ~/kb/qzserver/pacman_packages.txt
paru -S --needed --noconfirm - < ~/kb/qzserver/aur_packages.txt

# 3. Setup Config Symlinks
echo "🔗 Setting up configuration links..."
mkdir -p ~/.config
ln -sf ~/kb/qzserver/fish ~/.config/fish
ln -sf ~/kb/qzserver/wezterm ~/.config/wezterm
ln -sf ~/kb/qzserver/starship.toml ~/.config/starship.toml

# 4. Apply Headless Server Tweaks (Lid Close)
echo "🌙 Configuring lid behavior..."
sudo sed -i 's/#HandleLidSwitch=.*/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
sudo sed -i 's/#HandleLidSwitchExternalPower=.*/HandleLidSwitchExternalPower=ignore/' /etc/systemd/logind.conf
sudo systemctl restart systemd-logind

# 5. CLI Tools
mkdir -p ~/.local/bin
ln -sf ~/kb/qzserver/cli/cvc ~/.local/bin/cvc

echo "✅ Deployment complete! Please restart your shell (fish)."
