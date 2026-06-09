#!/bin/bash

echo "Installing Midnight Autoclicker..."

# Define standard Linux user directories
APP_DIR="$HOME/.local/share/midnight_clicker"
APP_MENU_DIR="$HOME/.local/share/applications"

# Create directories
mkdir -p "$APP_DIR" "$APP_MENU_DIR"

# Download the script and logo from your repo (REPLACE THE URLS!)
curl -sfL "https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/clicker.py" -o "$APP_DIR/clicker.py"
curl -sfL "https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/logo.png" -o "$APP_DIR/logo.png"

# Install Linux Dependencies
pip3 install --user customtkinter evdev

# Make it executable
chmod +x "$APP_DIR/clicker.py"

# Apply kernel udev rules for the mouse injection
echo "Applying Linux input permissions... (You may be prompted for your password)"
sudo usermod -aG input $USER
echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-uinput.rules > /dev/null
sudo udevadm control --reload-rules && sudo udevadm trigger

# Create the .desktop file for the App Dock
cat > "$APP_MENU_DIR/midnight-clicker.desktop" << EOF
[Desktop Entry]
Name=Midnight Autoclicker
Comment=Brutalist Cross-Platform Autoclicker
Exec=$APP_DIR/clicker.py
Icon=$APP_DIR/logo.png
Terminal=false
Type=Application
Categories=Utility;
EOF

# Update app menu database
update-desktop-database "$APP_MENU_DIR" 2>/dev/null

echo "Installation Complete!"
echo "IMPORTANT: Please log out and log back in (or restart your computer) to apply the kernel permissions!"
