# Tmux and Neovim Configuration

A clean, efficient setup for Tmux and Neovim focused on productivity and a beautiful, consistent theme. This repository provides a minimal yet powerful configuration for a terminal-based workflow.

---

## Tmux Configuration

This Tmux configuration is designed for a streamlined workflow with an emphasis on Vim-style keybindings and useful popup scripts.

### Features

* **Custom Prefix:** `Ctrl-Space` is used as the prefix key instead of the default `Ctrl-b`.
* **Popup Scripts:** Access common tools like `lazygit`, an interactive session switcher using `fzf`, and a new session creator directly from popups.
* **Vim-style Navigation:** Panes can be navigated using `h`, `j`, `k`, and `l` keys.
* **Mouse Support:** Mouse support is enabled for easy pane resizing and switching.
* **Status Bar:** The status bar is moved to the top and displays session information.
* **Catppuccin Mocha Theme:** A beautiful, dark theme is applied to provide a consistent look across sessions.
* **Start Index:** Windows and panes are renumbered to start at 1 instead of 0.

### Prerequisites

* **tmux 3.2+**
* **lazygit** (for the git popup)
* **fzf** (for the session switcher)
* **A Nerd Font** (for proper icon display)

### Key Bindings

* **Prefix Key:** `Ctrl-Space`
* **Reload Config:** `Prefix + r`
* **Rename Window:** `Prefix + Ctrl-r`
* **Kill Sessions:** `Prefix + Ctrl-q` kills all other sessions.
* **Pane Navigation:** `Prefix + h/j/k/l`
* **Split Panes:**
    * `Prefix + |` (horizontal)
    * `Prefix + -` (vertical)
* **Popup Scripts:**
    * `Prefix + Ctrl-y`: **Lazygit** popup
    * `Prefix + Ctrl-t`: **Terminal** popup
    * `Prefix + Ctrl-n`: **New session** creator
    * `Prefix + Ctrl-j`: **Session switcher**
* **Copy Mode:**
    * `Prefix + Enter`: Enter copy mode
    * `v`: Begin selection
    * `y`: Copy selection
    * `Prefix + p`: Paste

---

## Neovim Configuration

This Neovim setup is configured in Lua, with a focus on a fast startup using `lazy.nvim` and provides a comprehensive suite of plugins for a modern development environment.

### Features

* **Core Settings:** Includes settings for line numbers (`number`, `relativenumber`), tabs, indents, and a clean UI.
* **Lazy Loading:** Uses the `lazy.nvim` plugin manager to ensure a fast startup.
* **LSP and Autocompletion:** Integrates `nvim-lspconfig`, `mason.nvim`, and `nvim-cmp` for language support, code completion, and snippets. The configuration is set up for `clangd`, `rust_analyzer`, `gopls`, and `lua_ls`.
* **Treesitter:** Provides advanced syntax highlighting and indentation.
* **Telescope:** The `telescope.nvim` plugin is configured for fuzzy-finding files and searching with keybindings like `<leader>ff` and `<leader>fg`.
* **Auto-Formatting:** Uses `conform.nvim` to automatically format code on save.
* **Catppuccin Mocha Theme:** The editor theme is set to match the Tmux theme for a consistent look and feel.
* **Keymaps:** Includes custom keymaps for fast escapes (`jk`), buffer navigation (`Shift + h/l`), and a visual indent/outdent (`<`/`>`).

### Key Bindings

* **Leader Key:** `Space`
* **Navigation:**
    * `Shift + h`: Previous buffer
    * `Shift + l`: Next buffer
* **Find/Search:**
    * `<leader>ff`: Find files
    * `<leader>fg`: Live grep
    * `<leader>fb`: Find buffers
* **LSP:**
    * `gd`: Go to definition
    * `gr`: Go to references
    * `K`: Hover information
    * `<leader>ca`: Code action
    * `<leader>rn`: Rename
* **Formatting:**
    * `<leader>f`: Format file

---

## Installation

1.  **Clone the repository:** Clone the repository to your local machine.
2.  **Tmux Configuration:**
    * Copy the `.tmux.conf` file to your home directory (`~/.tmux.conf`).
    * Follow the instructions in the original README to install TPM and the Catppuccin theme.
3.  **Neovim Configuration:**
    * Copy the contents of the `nvim` folder to `~/.config/nvim`.
    * Open Neovim and the `lazy.nvim` plugin manager will automatically bootstrap and install the required plugins.
