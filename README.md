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
brew install tmux lazygit fzf
brew install --cask font-jetbrains-mono-nerd-font
````

Set up fzf key bindings and completion:

```bash
$(brew --prefix)/opt/fzf/install
```

### Installation Steps

1. **Clone the repository**

```bash
git clone <repository-url> ~/tmux-neovim-config
```

2. **Copy Tmux configuration**

```bash
cp ~/tmux-neovim-config/.tmux.conf ~/.tmux.conf
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
| Terminal Popup         | `Ctrl-Space + Ctrl-t`  |
| New Session            | `Ctrl-Space + Ctrl-n`  |
| Session Switcher       | `Ctrl-Space + Ctrl-j`  |
| Enter Copy Mode        | `Ctrl-Space + Enter`   |
| Select & Copy          | `v` / `y`              |

---

## Setting Up Neovim

Neovim is a modern, extensible text editor. This configuration (in Lua) uses **lazy.nvim** for plugin management and includes tools for coding, debugging, and version control.

### Key Features

* **Core Settings:** Line numbers, consistent tabs/indents, clean UI
* **Plugin Management:** lazy.nvim for fast startup
* **Language Support:** `nvim-lspconfig`, `mason.nvim`, `nvim-cmp` (clangd, rust\_analyzer, pyright, lua\_ls)
* **Syntax Highlighting:** `nvim-treesitter`
* **Fuzzy Finding:** `telescope.nvim`
* **Auto-Formatting:** `conform.nvim` on save
* **Catppuccin Mocha Theme:** Unified with Tmux
* **Python Integration:** `.venv` support via uv
* **Session Management:** `persistence.nvim`
* **Git Integration:** `gitsigns.nvim`

### Prerequisites

Install dependencies via Homebrew:

```bash
brew install neovim git node python uv rust clang-format ripgrep fd
```

### Installation Steps

1. **Copy Neovim configuration**

```bash
cp -r ~/tmux-neovim-config/nvim ~/.config/nvim
```

2. **Bootstrap plugins**
   Open Neovim to automatically install `lazy.nvim` and plugins:

```bash
nvim
```

3. **Install formatters** via mason.nvim
   Inside Neovim:

```vim
:MasonInstall black isort clang-format stylua
```

4. **Restart Neovim**

---

### Key Bindings

**Leader Key:** `Space`

**Buffer Navigation:**

* `Shift + h/l`: Previous/Next buffer
* `Ctrl + h/j/k/l`: Move between windows
* `Ctrl + d/u`: Scroll down/up (centered)
* `n/N`: Next/Previous search result

**Fuzzy Finding (Telescope):**

* `<leader>ff`: Find files
* `<leader>fg`: Live grep
* `<leader>fb`: List open buffers
* `<leader>fs/fw`: Find document/workspace symbols

**LSP (Language Server Protocol):**

* `gd`: Go to definition
* `gr`: Go to references
* `gI`: Go to implementation
* `gy`: Go to type definition
* `K`: Hover info
* `gK`: Signature help
* `<leader>ca`: Code action
* `<leader>rn`: Rename symbol
* `]d/[d`: Next/Previous diagnostic
* `<leader>q`: Diagnostics in location list

**Formatting:** `<leader>f` (auto-format on save)

**Debugging (DAP):**

* `<leader>db/dc/ds/di/do/du`: Breakpoints, step, UI toggle

**Testing (Neotest):**

* `<leader>tr/tf/ts`: Run tests

**Session Management:**

* `<leader>qs/ql`: Restore session / last session

**Git Integration (gitsigns):**

* `]c/[c`: Next/Previous hunk
* `<leader>hs/hr/hp`: Stage, reset, preview hunk

**Terminal:**

* `<leader>tt`: Open terminal
* `<leader>tp`: Open Python REPL via uv

---

## Troubleshooting

* **Tmux icons not displaying:** Ensure Nerd Font installed & configured.
* **Neovim plugins not loading:** Run `:Lazy` to verify lazy.nvim installation.
* **LSP servers not working:** Confirm Node.js & language-specific dependencies installed.
* **Slow startup:** Ensure `ripgrep` and `fd` are installed for telescope.nvim.
