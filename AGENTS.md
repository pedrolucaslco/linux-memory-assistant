## Commit Convention

Use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>
```

Types: `feat`, `fix`, `refactor`, `docs`, `chore`, `style`, `test`, `perf`.

Examples:
- `feat(install): add Fedora/dnf support for zenity installation`
- `fix(monitor): correct memory leak on poll interval`
- `docs(readme): update installation instructions`

## Project Structure

- `install.sh` — single entrypoint; run `./install.sh` to install or update
- `bin/memory-assistant` — the daemon loop (polls every 1s, alerts via zenity)
- `bin/check-status` — check if daemon is running, prompt to start if not
- No build, test, lint, or typecheck system (pure bash)

## Key Facts

- **Dependency installation:** `zenity` is auto-installed via `apt` (Debian/Ubuntu) or `dnf` (Fedora). `canberra-gtk-play` (sound) is NOT checked — install manually if needed.
- **Install path:** `~/.local/share/plco-memory-assistant/bin/`
- **Daemon is NOT a systemd service** — runs via `~/.config/autostart/plco-memory-assistant.desktop` (GNOME autostart) started by `nohup`. To restart after code changes, re-run `./install.sh` (it kills + restarts the daemon).
- **Manual start:** `nohup ~/.local/share/plco-memory-assistant/bin/memory-assistant >/dev/null 2>&1 &`
- **Uninstall:** `pkill -f memory-assistant && rm -rf ~/.local/share/plco-memory-assistant && rm -f ~/.config/autostart/plco-memory-assistant.desktop`
- **Threshold:** hardcoded at 80% in `bin/memory-assistant:3`
- **`bin/` must exist in CWD** for `install.sh` to succeed.
- **Status script:** `~/.local/bin/check-status` (symlink) opens a TUI menu with status, start/stop/restart, alert preview, and top processes. Run `check-status --alert` to preview the alert window without hitting the threshold.
- **Global access:** `install.sh` creates `~/.local/bin/check-status` symlink and adds it to PATH. Run `check-status` from anywhere.
