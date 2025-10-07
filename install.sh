#!/bin/bash
set -e

# check & install dependencies
if ! command -v zenity &> /dev/null; then
    echo "zenity not found, installing..."
    sudo apt update && sudo apt install -y zenity
fi

LOCAL_PATH="$HOME/.local/share/plco-memory-assistant"

# ensure target directory exists
mkdir -p "$LOCAL_PATH"

# copy bin folder to ~/.local/share/plco-memory-assistant
if [ -d "bin" ]; then
    cp -r "bin" "$LOCAL_PATH/"
else
    echo "Error: 'bin' folder not found in current directory."
    exit 1
fi

# ensure memory-assistant is executable
chmod +x "$LOCAL_PATH/bin/memory-assistant" 2>/dev/null || true

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

echo "✅ Memory Assistant installed successfully!"
echo "📂 Location: $LOCAL_PATH"
