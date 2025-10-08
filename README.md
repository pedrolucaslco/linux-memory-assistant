# 🧠 PLCO Memory Assistant

A lightweight Linux helper that alerts you when your system memory usage gets too high — inspired by macOS-style alerts.

## ⚙️ Installation

Run the installer:

```bash
./install.sh
```

## 🚀 Running Manually

If you want to start it right away (without rebooting):

```bash
nohup ~/.local/share/plco-memory-assistant/bin/memory-assistant >/dev/null 2>&1 &
```

## 🔍 Checking Status

Use the included check-status script:

```bash
~/.local/share/plco-memory-assistant/bin/check-status
```

It will:

Show whether the service is running and display its PID

Offer to start it if it’s not running

Example output:

```bash
✅ memory-assistant is running (PID: 12345)

or

❌ memory-assistant is not running
Start it now? (y/n):
```

🧪 Testing the Assistant

To verify it’s working:

Run check-status and confirm the process is active.

Open several apps or use a memory-stress tool to push RAM usage above your configured threshold.

A Zenity alert should appear when memory usage passes the limit.

🧼 Uninstall (optional)

To remove everything:

```bash
pkill -f memory-assistant 2>/dev/null
rm -rf ~/.local/share/plco-memory-assistant
rm -f ~/.config/autostart/plco-memory-assistant.desktop
echo "✅ Memory Assistant removed."
```