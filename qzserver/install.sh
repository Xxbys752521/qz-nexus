#!/bin/bash

# QZ Server Deployment Script
# Targets: CachyOS / Arch Linux
# This script is located in qzserver/ folder

set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
KB_ROOT="$( dirname "$SCRIPT_DIR" )"

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
paru -S --needed --noconfirm - < "$SCRIPT_DIR/pacman_packages.txt"
paru -S --needed --noconfirm - < "$SCRIPT_DIR/aur_packages.txt"

# 3. Setup Config Symlinks
echo "🔗 Setting up configuration links..."
mkdir -p ~/.config
ln -sf "$SCRIPT_DIR/fish" ~/.config/fish
ln -sf "$SCRIPT_DIR/wezterm" ~/.config/wezterm
ln -sf "$SCRIPT_DIR/starship.toml" ~/.config/starship.toml

# 4. Apply Headless Server Tweaks (Lid Close)
echo "🌙 Configuring lid behavior..."
sudo sed -i 's/#HandleLidSwitch=.*/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
sudo sed -i 's/#HandleLidSwitchExternalPower=.*/HandleLidSwitchExternalPower=ignore/' /etc/systemd/logind.conf
sudo systemctl restart systemd-logind

# 5. CLI Tools
echo "🛠️ Linking CLI tools..."
mkdir -p ~/.local/bin
ln -sf "$SCRIPT_DIR/cli/cvc" ~/.local/bin/cvc

echo "✅ Deployment complete! Please restart your shell (fish)."
