#!/bin/bash

echo "Installing Midnight Autoclicker..."

# Define standard Linux user directories
APP_DIR="$HOME/.local/share/midnight_clicker"
BIN_DIR="$HOME/.local/bin"
APP_MENU_DIR="$HOME/.local/share/applications"

# Create directories
mkdir -p "$APP_DIR" "$BIN_DIR" "$APP_MENU_DIR"

# Download the script and logo from your repo (REPLACE THE URLS)
curl -sfL "https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/clicker.py" -o "$APP_DIR/clicker.py"
curl -sfL "https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/logo.png" -o "$APP_DIR/logo.png"

# Make it executable
chmod +x "$APP_DIR/clicker.py"

# Create the .desktop file for the App Dock
cat > "$APP_MENU_DIR/midnight-clicker.desktop" << EOF
[Desktop Entry]
Name=Midnight Autoclicker
Comment=Brutalist Kernel-Level Autoclicker
Exec=$APP_DIR/clicker.py
Icon=$APP_DIR/logo.png
Terminal=false
Type=Application
Categories=Utility;
EOF

# Update app menu database
update-desktop-database "$APP_MENU_DIR" 2>/dev/null

echo "Installation Complete! You can now find Midnight Autoclicker in your application menu."
