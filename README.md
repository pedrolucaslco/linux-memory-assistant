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

## 🔍 Checking & Managing

After installation, run `check-status` from anywhere to open the interactive TUI:

```
╔══════════════════════════════════════════╗
║        PLCO Memory Assistant             ║
╠══════════════════════════════════════════╣
║  Status:   Running    PID: 12345         ║
║  Uptime:   02:15:30                      ║
║                                          ║
║  Memory:   45% (Threshold: 80%)          ║
╚══════════════════════════════════════════╝

  1) Start daemon
  2) Stop  daemon
  3) Restart daemon
  4) Test alert (zenity preview)
  5) View top processes
  6) Exit
```

Use `--alert` to preview directly:

```bash
check-status --alert
```

If `check-status` is not found after install, run `source ~/.bashrc` or restart the terminal.

## 🧼 Uninstall (optional)

To remove everything:

```bash
pkill -f memory-assistant 2>/dev/null
rm -rf ~/.local/share/plco-memory-assistant
rm -f ~/.config/autostart/plco-memory-assistant.desktop
echo "✅ Memory Assistant removed."
```