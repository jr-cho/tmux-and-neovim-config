# Minimal Tmux Configuration

A clean, efficient tmux setup focused on productivity with popup scripts and beautiful catppuccin theming.

## Features

- **Catppuccin Mocha theme** with rounded window tabs
- **Popup scripts** for common workflows (lazygit, session management, terminal)
- **Vim-style navigation** for panes
- **Mouse support** enabled
- **Status bar at top** with session info
- **Windows/panes start at 1** (not 0)

## Prerequisites

- **tmux 3.2+** (required for catppuccin theme)
- **lazygit** (for git popup)
- **fzf** (for session switcher)
- **Nerd Font** (for proper icon display)

### Install Prerequisites (Arch Linux)

```bash
# Install dependencies
sudo pacman -S tmux lazygit fzf

# Install a Nerd Font (choose one)
sudo pacman -S ttf-jetbrains-mono-nerd
sudo pacman -S ttf-firacode-nerd
```

## Installation

### 1. Backup existing config (if any)
```bash
cp ~/.tmux.conf ~/.tmux.conf.backup
```

### 2. Install fresh TPM and catppuccin
```bash
# Remove old plugins
rm -rf ~/.tmux/plugins

# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install catppuccin directly
mkdir -p ~/.config/tmux/plugins
git clone https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin
```

### 3. Copy configuration
Copy the tmux configuration to `~/.tmux.conf`

### 4. Load configuration
```bash
# Start tmux
tmux

# Install TPM plugins (inside tmux)
Ctrl-Space + I

# Reload config
tmux source ~/.tmux.conf
```

## Key Bindings

### Prefix Key
- **Prefix:** `Ctrl-Space` (instead of default Ctrl-b)

### Basic Commands
| Key | Action |
|-----|--------|
| `Prefix + r` | Reload config |
| `Prefix + C-r` | Rename window |
| `Prefix + C-q` | Kill all other sessions |

### Pane Navigation
| Key | Action |
|-----|--------|
| `Prefix + h/j/k/l` | Move between panes (vim-style) |

### Window Navigation
| Key | Action |
|-----|--------|
| `Shift + Left/Right` | Switch between windows |

### Pane Splitting
| Key | Action |
|-----|--------|
| `Prefix + \|` | Split horizontal |
| `Prefix + \\` | Split horizontal (full width) |
| `Prefix + -` | Split vertical |
| `Prefix + _` | Split vertical (full height) |

### Popup Scripts
| Key | Action |
|-----|--------|
| `Prefix + Ctrl-y` | **Lazygit** popup (80% screen) |
| `Prefix + Ctrl-t` | **Terminal** popup (75% screen) |
| `Prefix + Ctrl-n` | **New session** creator |
| `Prefix + Ctrl-j` | **Session switcher** with fzf |

### Copy Mode
| Key | Action |
|-----|--------|
| `Prefix + Enter` | Enter copy mode |
| `v` | Start selection (in copy mode) |
| `y` | Copy selection (in copy mode) |
| `Prefix + p` | Paste |

## Popup Scripts Explained

### Lazygit (`Ctrl-Space + Ctrl-y`)
Opens lazygit in a popup window for quick git operations without leaving your current context.

### Terminal (`Ctrl-Space + Ctrl-t`)
Spawns a new bash shell in a popup - perfect for quick commands.

### New Session (`Ctrl-Space + Ctrl-n`)
Interactive session creator - prompts for session name and creates/switches to it.

### Session Switcher (`Ctrl-Space + Ctrl-j`)
Uses fzf to provide a fuzzy-searchable list of existing sessions (excludes current session).

## Theme Customization

### Change Catppuccin Flavor
```bash
# In ~/.tmux.conf, change:
set -g @catppuccin_flavour 'mocha'   # dark
set -g @catppuccin_flavour 'latte'   # light
set -g @catppuccin_flavour 'frappe'  # medium dark
set -g @catppuccin_flavour 'macchiato' # medium
```

### Customize Window Style
```bash
# Options: basic, rounded, slanted, custom, none
set -g @catppuccin_window_status_style "rounded"
```

## Troubleshooting

### Theme not loading
1. Ensure catppuccin is installed:
   ```bash
   ls ~/.config/tmux/plugins/catppuccin/
   ```

2. Check tmux version:
   ```bash
   tmux -V  # Should be 3.2+
   ```

3. Force reload:
   ```bash
   tmux kill-server
   tmux
   ```

### Popup scripts not working
- **lazygit:** Install with `sudo pacman -S lazygit`
- **fzf:** Install with `sudo pacman -S fzf`
- **Bash:** Should be available by default

### Icons not displaying
Install a Nerd Font and set it in your terminal emulator settings.

## File Structure

```
~/.tmux.conf                           # Main config file
~/.tmux/plugins/tpm/                   # Plugin manager
~/.config/tmux/plugins/catppuccin/     # Theme
```

## Updating

### Update plugins
```bash
# Inside tmux
Ctrl-Space + U    # Update all plugins
```

### Update catppuccin manually
```bash
cd ~/.config/tmux/plugins/catppuccin
git pull origin main
```

## Philosophy

This configuration prioritizes:
- **Minimal bloat** - only essential features
- **Popup workflows** - keep context while accessing tools
- **Vim-style navigation** - consistent with editor habits
- **Beautiful but functional** - catppuccin theme without performance cost

Perfect for developers who want a clean, efficient tmux setup without unnecessary complexity.
