#!/bin/bash
set -e

# check & install dependencies
if ! command -v zenity &> /dev/null; then
    echo "zenity not found, installing..."
    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y zenity
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y zenity
    else
        echo "Error: no supported package manager found (apt, dnf). Install zenity manually."
        exit 1
    fi
fi

LOCAL_PATH="$HOME/.local/share/plco-memory-assistant"

# check if already installed
if [ -d "$LOCAL_PATH/bin" ]; then
    echo "Existing installation found, updating files..."
    if command -v rsync &> /dev/null; then
        rsync -a "bin/" "$LOCAL_PATH/bin/"
    else
        cp -r "bin/" "$LOCAL_PATH/bin/"
    fi
    # restart the daemon with updated files
    if pgrep -f "$LOCAL_PATH/bin/memory-assistant" > /dev/null 2>&1; then
        echo "Restarting memory-assistant daemon..."
        pkill -f "$LOCAL_PATH/bin/memory-assistant" 2>/dev/null || true
        sleep 0.5
        nohup "$LOCAL_PATH/bin/memory-assistant" >/dev/null 2>&1 &
    fi
else
    mkdir -p "$LOCAL_PATH"
    if [ -d "bin" ]; then
        cp -r "bin" "$LOCAL_PATH/"
    else
        echo "Error: 'bin' folder not found in current directory."
        exit 1
    fi
fi

# ensure all bin files is executable
chmod +x "$LOCAL_PATH/bin/"* 2>/dev/null || true

# install autostart entry
mkdir -p "$HOME/.config/autostart"
cat > "$HOME/.config/autostart/plco-memory-assistant.desktop" <<EOF
[Desktop Entry]
Type=Application
Exec=$LOCAL_PATH/bin/memory-assistant
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Memory Assistant
Comment=Alert of memory usage like macOS
EOF

# create global symlink in ~/.local/bin
mkdir -p "$HOME/.local/bin"
ln -sf "$LOCAL_PATH/bin/check-status" "$HOME/.local/bin/check-status"

# ensure ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    profile_file="$HOME/.bashrc"
    if [ -f "$HOME/.bash_profile" ]; then
        profile_file="$HOME/.bash_profile"
    elif [ -f "$HOME/.profile" ]; then
        profile_file="$HOME/.profile"
    fi
    if ! grep -q '\.local/bin' "$profile_file" 2>/dev/null; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$profile_file"
        echo "Added ~/.local/bin to PATH in $profile_file"
        echo "Run 'source $profile_file' or restart your terminal to use 'check-status' directly."
    fi
fi

echo "✅ Memory Assistant installed successfully!"
echo "📂 Location: $LOCAL_PATH"
echo "💡 Run 'check-status' from anywhere to open the TUI."
