# Tmux + Neovim Productivity Setup

This guide walks you through configuring **Tmux** and **Neovim** for a productive, visually consistent development environment. The setup is optimized for **Vim-style keybindings**, modern plugins, and the **Catppuccin Mocha theme**.  

It assumes you're using **Homebrew** as your package manager on macOS or Linux.

---

## Table of Contents
- [Setting Up Tmux](#setting-up-tmux)
  - [Key Features](#key-features)
  - [Prerequisites](#prerequisites)
  - [Installation Steps](#installation-steps)
  - [Key Bindings](#key-bindings)
- [Setting Up Neovim](#setting-up-neovim)
  - [Key Features](#key-features-1)
  - [Prerequisites](#prerequisites-1)
  - [Installation Steps](#installation-steps-1)
  - [Key Bindings](#key-bindings-1)
- [Troubleshooting](#troubleshooting)

---

## Setting Up Tmux

Tmux is a terminal multiplexer that lets you manage multiple terminal sessions efficiently. This configuration focuses on ease of use, intuitive navigation, and integration with tools like **lazygit** and **fzf**.

### Key Features
- **Custom Prefix Key:** `Ctrl-Space` instead of default `Ctrl-b`
- **Popup Scripts:** Quick access to lazygit, session switcher, and new session creation
- **Vim-Style Navigation:** Move between panes using `h`, `j`, `k`, `l`
- **Mouse Support:** Resize and switch panes using mouse
- **Custom Status Bar:** Top-positioned, displays session info
- **Catppuccin Mocha Theme:** Dark, consistent theme
- **Window & Pane Indexing:** Starts at 1 for intuitive numbering

### Prerequisites
Install the following dependencies via Homebrew:

```bash
brew install tmux lazygit fzf lazydocker
brew install --cask font-jetbrains-mono-nerd-font
````

Set up fzf key bindings and completion:

```bash
$(brew --prefix)/opt/fzf/install
```

### Installation Steps

1. **Clone the repository**

2. **Copy Tmux configuration**

```bash
cp ~/tmux-and-neovim-config/.tmux.conf ~/.tmux.conf
```

3. **Install Tmux Plugin Manager (TPM)**

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

4. **Install Catppuccin Mocha theme**
   Follow the [Catppuccin Tmux README](https://github.com/catppuccin/tmux) for installation.

5. **Reload Tmux configuration**

```bash
tmux source ~/.tmux.conf
```

Or within Tmux: `Ctrl-Space + r`

### Key Bindings

| Action                 | Shortcut               |
| ---------------------- | ---------------------- |
| Prefix Key             | `Ctrl-Space`           |
| Reload Config          | `Ctrl-Space + r`       |
| Rename Window          | `Ctrl-Space + Ctrl-r`  |
| Kill Other Sessions    | `Ctrl-Space + Ctrl-q`  |
| Navigate Panes         | `Ctrl-Space + h/j/k/l` |
| Split Panes Horizontal | `Ctrl-Space + \|`      |
| Split Panes Vertical   | `Ctrl-Space + -`       |
| LazyGit Popup          | `Ctrl-Space + Ctrl-y`  |
| LazyDocker Popup       | `Ctrl-Space + Ctrl-d`  |
| Terminal Popup         | `Ctrl-Space + Ctrl-t`  |
| New Session            | `Ctrl-Space + Ctrl-n`  |
| Session Switcher       | `Ctrl-Space + Ctrl-j`  |
| Enter Copy Mode        | `Ctrl-Space + Enter`   |
| Select & Copy          | `v` / `y`              |

---

## Setting Up Neovim

Neovim is a modern, extensible text editor. This configuration (in Lua) uses **lazy.nvim** for plugin management and includes tools for coding and version control.

### Key Features

* **Core Settings:** Line numbers, relative numbers, consistent tabs/indents, system clipboard integration
* **Plugin Management:** lazy.nvim for fast startup
* **Language Support:** Native LSP with `mason.nvim`, `nvim-cmp` (clangd, pyright, lua_ls)
* **Syntax Highlighting:** `nvim-treesitter`
* **Fuzzy Finding:** `telescope.nvim`
* **File Explorer:** `nvim-tree.lua`
* **Catppuccin Mocha Theme:** Clean, modern colorscheme
* **Python Integration:** `.venv` support via uv
* **Alpha Dashboard:** Beautiful startup screen

### Prerequisites

Install dependencies via Homebrew:

```bash
brew install neovim git python uv clang ripgrep fd
```

**For Linux clipboard support:**

```bash
# Ubuntu/Debian
sudo apt install xclip

# Arch
sudo pacman -S xclip

# Fedora
sudo dnf install xclip
```

### Installation Steps

1. **Copy Neovim configuration**

```bash
cp -r ~/tmux-and-neovim-config/nvim ~/.config/nvim
```

2. **Bootstrap plugins**

   Open Neovim to automatically install `lazy.nvim` and plugins:

```bash
nvim
```

3. **Install LSP servers** via Mason

   Inside Neovim:

```vim
:Mason
```

   Then install: `clangd`, `pyright`, `lua_ls`

4. **Restart Neovim**

---

### Key Bindings

**Leader Key:** `Space`

**File Operations:**

* `<leader>w`: Save file
* `<leader>q`: Quit
* `<leader>t`: Toggle file tree

**Fuzzy Finding (Telescope):**

* `<leader>f`: Find files
* `<leader>g`: Live grep (search in files)
* `<leader>r`: Recent files

**LSP (Language Server Protocol):**

* `gd`: Go to definition
* `gr`: Go to references
* `K`: Hover documentation
* `<leader>rn`: Rename symbol
* `<leader>ca`: Code action
* `[d` / `]d`: Previous/Next diagnostic
* `<leader>e`: Show diagnostic float

**System Clipboard:**

* `<leader>y`: Yank to system clipboard (normal/visual mode)
* `<leader>p`: Paste from system clipboard
* `<leader>Y`: Yank line to system clipboard
* `<leader>P`: Paste before cursor from system clipboard

**Quick Actions:**

* `<leader>h`: Clear search highlighting
* `<F5>`: Compile and run C file (clang)
* `<F6>`: Run Python file with uv

---

## Troubleshooting

* **Icons not displaying:** Ensure a Nerd Font is installed & configured in your terminal.
* **Neovim plugins not loading:** Run `:Lazy` to verify lazy.nvim installation.
* **LSP servers not working:** Run `:Mason` and install the required language servers.
* **Clipboard not working on Linux:** Install `xclip` or `xsel`.
* **Slow fuzzy finding:** Ensure `ripgrep` and `fd` are installed for telescope.nvim.
* **Python LSP not detecting venv:** Make sure you have a `.venv` directory in your project root created with `uv venv`.
