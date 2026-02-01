# Terminal Development Environment

## Requirements

### Core Tools
- Neovim >= 0.10.0
- tmux >= 3.0
- Git
- Node.js (for Copilot)
- Python3 (for Python LSP and debugging)
- ripgrep (for Telescope live grep)
- fd (optional, for faster file finding)
- fzf (for tmux session switching)

### Optional Tools
- lazygit (for git TUI)
- lazydocker (for docker TUI)
- yazi (file manager)

### Language Servers
```bash
# C/C++
brew install llvm  # or apt-get install clangd

# Python
pip install pyright debugpy

# Lua
brew install lua-language-server
```

## Installation

### 1. Backup existing configs
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.tmux.conf ~/.tmux.conf.backup
mv ~/.zshrc ~/.zshrc.backup
```

### 2. Install configurations
```bash
# Neovim
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/init.lua

# tmux
cp .tmux.conf ~/.tmux.conf

# Zsh
cp .zshrc ~/.zshrc
```

### 3. Install tmux Plugin Manager (TPM)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 4. Launch and configure
```bash
# Start tmux
tmux

# Inside tmux, install plugins: Prefix + I (Ctrl+Space then Shift+I)

# Launch Neovim
nvim

# Configure Copilot
:Copilot auth
```

## Tmux Keybindings

### Prefix Key
The prefix is `Ctrl+Space` (fallback: `Ctrl+a`)
- Most commands require pressing prefix first, then the key
- Example: `Prefix + r` means `Ctrl+Space` then `r`

### Essential Commands

#### Configuration
```
Prefix + r            Reload tmux configuration
```

#### Pane Navigation (Vim-style)
```
Prefix + h            Move to left pane
Prefix + j            Move to bottom pane
Prefix + k            Move to top pane
Prefix + l            Move to right pane
```

#### Seamless Vim + tmux Navigation
```
Ctrl+h                Move left (works in both Vim and tmux)
Ctrl+j                Move down (works in both Vim and tmux)
Ctrl+k                Move up (works in both Vim and tmux)
Ctrl+l                Move right (works in both Vim and tmux)
```
*No prefix needed - automatically detects if you're in Vim*

#### Window Splitting
```
Prefix + |            Split horizontally (side by side)
Prefix + \            Split horizontally (full width)
Prefix + -            Split vertically (top/bottom)
Prefix + _            Split vertically (full height)
```
*All splits preserve current working directory*

#### Popup Windows (No Prefix)
```
Ctrl+Space + Ctrl+y   Lazygit popup (80% screen, centered)
Ctrl+Space + Ctrl+d   Lazydocker popup (80% screen)
Ctrl+Space + Ctrl+t   Terminal popup (75% screen)
Ctrl+Space + Ctrl+n   Create new session (prompts for name)
Ctrl+Space + Ctrl+j   Fuzzy session switcher (fzf)
```

#### Session Management
```
Prefix + Ctrl+q       Kill all sessions except current
Prefix + Ctrl+r       Rename current window
Prefix + d            Detach from session
Prefix + $            Rename session
```

#### Window Management
```
Prefix + c            Create new window
Prefix + ,            Rename current window
Prefix + n            Next window
Prefix + p            Previous window
Prefix + 0-9          Switch to window number
Prefix + &            Kill current window
```

#### Pane Management
```
Prefix + x            Kill current pane
Prefix + z            Zoom/unzoom current pane (fullscreen)
Prefix + {            Swap pane with previous
Prefix + }            Swap pane with next
Prefix + Space        Cycle through pane layouts
Prefix + q            Show pane numbers
```

#### Copy Mode (Vim-style)
```
Prefix + [            Enter copy mode
v                     Begin selection (in copy mode)
y                     Copy selection and exit (in copy mode)
q                     Exit copy mode
```

### Mouse Support
- Click to select pane
- Drag to resize panes
- Scroll to view history
- Right-click for context menu

## Neovim Keybindings

Leader key is `Space`

### Essential Keybindings

#### Basic Operations
```
jj                    Exit insert mode (alternative to Esc)
<leader>w             Save current file
<leader>q             Quit current window
<Esc>                 Clear search highlighting
Ctrl+h/j/k/l          Navigate between split windows
Shift+H               Previous buffer (tab)
Shift+L               Next buffer (tab)
<leader>bd            Delete current buffer
<leader>-             Split window horizontally
<leader>|             Split window vertically
```

#### File Navigation and Search
```
<leader>e             Toggle file explorer (Neo-tree)
<leader>o             Reveal current file in explorer
<leader>ff            Find files by name
<leader>fg            Live grep (search text in all files)
<leader>fb            List and switch between open buffers
<leader>fr            Recent files
<leader>fh            Search help documentation
<leader>fs            Search document symbols (functions, classes)
<leader>fw            Search workspace symbols
<leader>ft            Find TODO/FIXME/NOTE comments
```

In Telescope (fuzzy finder):
```
Ctrl+j                Move to next result
Ctrl+k                Move to previous result
Ctrl+q                Send results to quickfix list
```

#### LSP (Language Server Protocol)

Navigation:
```
gd                    Go to definition
gD                    Go to declaration
gi                    Go to implementation
gt                    Go to type definition
gr                    Find all references
```

Code Actions:
```
K                     Show hover documentation
<leader>rn            Rename symbol under cursor
<leader>ca            Show code actions
<leader>lf            Format current document
<leader>d             Show diagnostics for current line
[d                    Jump to previous diagnostic
]d                    Jump to next diagnostic
```

#### GitHub Copilot

Inline Suggestions:
```
Alt+L                 Accept current suggestion
Alt+W                 Accept next word of suggestion
Alt+J                 Accept next line of suggestion
Alt+]                 Show next suggestion
Alt+[                 Show previous suggestion
Ctrl+]                Dismiss suggestion
Alt+Enter             Open Copilot panel
```

Copilot Chat:
```
<leader>cc            Toggle Copilot Chat window
<leader>ce            Explain selected code
<leader>ct            Generate tests for code
<leader>cf            Fix issues in code
```

In Copilot panel:
```
[[                    Jump to previous suggestion
]]                    Jump to next suggestion
Enter                 Accept suggestion
gr                    Refresh suggestions
```

#### Debugging (DAP)

Breakpoints and Control:
```
<leader>db            Toggle breakpoint on current line
<leader>dc            Continue (start or resume debugging)
<leader>di            Step into function
<leader>do            Step over function
<leader>dO            Step out of function
<leader>dr            Toggle debug REPL
<leader>dt            Terminate debug session
<leader>dl            Show debug logs
```

When debugging starts, DAP UI automatically opens showing:
- Variables and their values
- Call stack
- Breakpoints list
- Debug console

#### Testing (Neotest)
```
<leader>tn            Run nearest test (cursor position)
<leader>tf            Run all tests in current file
<leader>ts            Toggle test summary panel
<leader>to            Show detailed test output
```

#### Git Operations

Lazygit Integration:
```
<leader>gg            Open Lazygit (full git interface)
<leader>gb            Show git blame for current line
<leader>gf            Show file history in Lazygit
<leader>gl            Show repository log
```

Git Hunks (Gitsigns):
```
]c                    Jump to next changed hunk
[c                    Jump to previous changed hunk
<leader>hs            Stage current hunk
<leader>hr            Reset current hunk
<leader>hp            Preview hunk changes
```

#### Diagnostics and Error Navigation

Trouble (Diagnostics Panel):
```
<leader>xx            Toggle diagnostics for workspace
<leader>xX            Toggle diagnostics for current buffer
<leader>cs            Show document symbols
<leader>cl            Show LSP definitions/references
```

#### Code Navigation and Structure
```
<leader>a             Toggle code outline (Aerial)
{                     Previous function (when outline active)
}                     Next function (when outline active)
s                     Flash jump - type 2 characters to jump
S                     Flash treesitter - jump to code structure
```

#### Terminal
```
Ctrl+/                Toggle floating terminal
Ctrl+_                Toggle floating terminal (alternative)
```

Inside terminal:
```
Ctrl+\ then Ctrl+n    Exit terminal mode to normal mode
```

#### Text Editing

Clipboard:
```
<leader>y             Yank (copy) to system clipboard (normal/visual)
<leader>p             Paste from system clipboard
```

Comments:
```
gcc                   Toggle comment on current line
gc                    Toggle comment on selection (visual mode)
```

Surround (change quotes, brackets, etc):
```
ys{motion}{char}      Add surrounding character
                      Example: ysiw" surrounds word with quotes
cs{old}{new}          Change surrounding character
                      Example: cs"' changes " to '
ds{char}              Delete surrounding character
                      Example: ds" removes surrounding quotes
```

Moving Lines:
```
J                     Move selected lines down (visual mode)
K                     Move selected lines up (visual mode)
```

#### Completion (nvim-cmp)
```
Tab                   Next completion item or expand snippet
Shift+Tab             Previous completion item
Enter                 Confirm selection
Ctrl+Space            Manually trigger completion
Ctrl+e                Close completion menu
Ctrl+b                Scroll documentation up
Ctrl+f                Scroll documentation down
```

#### Code Outline and Navigation
```
af                    Select outer function (text object)
if                    Select inner function
ac                    Select outer class
ic                    Select inner class
```

#### Quick Run Commands
```
F5                    Compile and run current C/C++ file
F6                    Run current Python file
```

#### Notifications
```
<leader>n             Show notification history
<leader>un            Dismiss all notifications
```

### File Explorer (Neo-tree) Commands

When focused on Neo-tree:
```
a                     Create new file or directory
d                     Delete file/directory
r                     Rename file/directory
y                     Copy file path to clipboard
x                     Cut file
p                     Paste file
R                     Refresh tree
H                     Toggle hidden files
/                     Filter files
```

## Workflow Examples

### Opening and Navigating Files
1. Press `<leader>ff` to fuzzy find files
2. Type partial filename to filter
3. Press Enter to open file
4. Use `Shift+L` and `Shift+H` to switch between open files

### Working with Code
1. Press `K` to see function documentation
2. Press `gd` to go to definition
3. Press `gr` to see all references
4. Use `<leader>rn` to rename across project
5. Press `<leader>ca` for available code actions

### Debugging Python
1. Set breakpoints with `<leader>db`
2. Start debugging with `<leader>dc`
3. Use `<leader>do` to step over
4. Use `<leader>di` to step into functions
5. Inspect variables in the DAP UI sidebar

### Using Copilot
1. Start typing - suggestions appear automatically
2. Press `Alt+L` to accept suggestion
3. Use `<leader>cc` to open chat for questions
4. Select code and press `<leader>ce` for explanations

### Git Workflow
1. Press `<leader>gg` to open Lazygit
2. Or use `]c` and `[c` to navigate changes
3. Use `<leader>hp` to preview changes
4. Stage hunks with `<leader>hs`

## Workflow Examples

### Starting a Development Session

1. **Create tmux session**:
```bash
tmux new -s myproject
```

2. **Setup layout**:
```
Prefix + |            Split for editor and terminal
Prefix + -            Split terminal for logs/tests
```

3. **Open Neovim**:
```bash
nvim
```

4. **Navigate files**:
```
<leader>e             Open file tree
<leader>ff            Fuzzy find files
```

### Working with Multiple Projects

1. **Create new session for second project**:
```
Ctrl+Space + Ctrl+n   Create new session popup
```

2. **Switch between sessions**:
```
Ctrl+Space + Ctrl+j   Fuzzy session switcher
```

3. **Or use tmux commands**:
```
Prefix + s            Session list (arrow keys to select)
```

### Git Workflow

#### In tmux:
```
Ctrl+Space + Ctrl+y   Open Lazygit popup
```

#### In Neovim:
```
<leader>gg            Open Lazygit
]c / [c               Navigate changes
<leader>hp            Preview hunk
<leader>hs            Stage hunk
<leader>gb            Git blame line
```

### Debugging Session

1. **Split panes for debugging**:
```
Prefix + |            Split for code and debug output
```

2. **In Neovim**:
```
<leader>db            Set breakpoints
<leader>dc            Start debugging
<leader>do            Step over
<leader>di            Step into
```

3. **Monitor in terminal pane**:
```
Ctrl+h/j/k/l          Navigate between code and terminal
```

### Code Navigation Workflow

1. **Find symbol**:
```
<leader>fs            Search document symbols
<leader>fw            Search workspace symbols
```

2. **Jump to definition**:
```
gd                    Go to definition
Ctrl+o                Jump back
Ctrl+i                Jump forward
```

3. **See all references**:
```
gr                    List all references
<leader>xx            View in Trouble panel
```

### Testing Workflow

1. **Split for test output**:
```
Prefix + -            Vertical split
```

2. **Run tests**:
```
<leader>tn            Run nearest test
<leader>tf            Run file tests
<leader>ts            Toggle test summary
```

3. **Watch terminal output**:
```
Ctrl+j                Switch to terminal pane
```

### Using Popups

#### Quick git commit:
```
Ctrl+Space + Ctrl+y   Lazygit popup
Stage files, commit, push
Esc                   Close popup
```

#### Quick shell command:
```
Ctrl+Space + Ctrl+t   Terminal popup
Run command
Ctrl+d                Exit and close
```

#### Session management:
```
Ctrl+Space + Ctrl+j   Session switcher
Type to filter
Enter to switch
```

### Pair Programming Setup

1. **Create shared session**:
```bash
tmux new -s pair
```

2. **Attach from another terminal**:
```bash
tmux attach -t pair
```

3. **Split for multiple views**:
```
Prefix + |            Split for editor
Prefix + -            Split for terminal
Prefix + z            Zoom pane for presenting
```

### Full Stack Development Layout

```
┌─────────────────────┬──────────────────┐
│                     │                  │
│   Neovim (code)     │  Terminal        │
│                     │  (server logs)   │
│                     │                  │
├─────────────────────┼──────────────────┤
│                     │                  │
│   Terminal          │  Lazygit popup   │
│   (tests/build)     │  (Ctrl+Space+Y)  │
│                     │                  │
└─────────────────────┴──────────────────┘
```

To create:
```
Prefix + |            First split
Prefix + -            Split left pane
Ctrl+h then Prefix -  Split right pane
```

### Copy/Paste Between tmux and System

#### From tmux to system:
```
Prefix + [            Enter copy mode
v                     Start selection
y                     Copy (automatically to system clipboard on macOS)
```

#### From system to tmux:
```
Cmd+V (macOS)         Paste directly
Ctrl+Shift+V (Linux)  Paste directly
```

## Customization

### Changing tmux Prefix
Edit `.tmux.conf`:
```bash
set -g prefix C-a     # Change to Ctrl+a
# or
set -g prefix C-b     # Change back to default
```

### Changing Neovim Leader
Edit `init.lua`:
```lua
vim.g.mapleader = ","  # Change to comma
```

### Adding Language Servers
Edit `init.lua`:
```lua
vim.lsp.config.your_lsp = {
  cmd = { "your-lsp-command" },
  filetypes = { "your-filetype" },
  root_markers = { ".git" },
  capabilities = capabilities,
}
vim.lsp.enable({ "your_lsp" })
```

### Customizing tmux Theme
Edit `.tmux.conf`:
```bash
set -g @catppuccin_flavour 'latte'    # Light theme
# or 'frappe', 'macchiato', 'mocha' (dark)
```

## Troubleshooting

### tmux

#### Plugins not installing:
```bash
# Inside tmux:
Prefix + I            Install plugins
Prefix + U            Update plugins
Prefix + alt+u        Uninstall unused plugins
```

#### Colors look wrong:
```bash
# Add to .zshrc:
export TERM="xterm-256color"

# In .tmux.conf (already included):
set -g default-terminal "tmux-256color"
```

#### Popup windows not working:
```bash
# Ensure tmux >= 3.2
tmux -V

# Update tmux:
brew upgrade tmux
```

### Neovim

#### Copilot not working:
```
:Copilot status
:Copilot auth
```

#### LSP not starting:
```
:LspInfo
```

#### Plugins not installing:
```
:Lazy sync
:Lazy clean
:Lazy update
```

### Integration Issues

#### Ctrl+h not working in Neovim inside tmux:
Already configured in both `.tmux.conf` and `init.lua` for seamless integration.

#### Mouse not working:
```bash
# In .tmux.conf (already included):
set -g mouse on
```

## Quick Reference Card

### Most Used Commands

#### tmux:
```
Ctrl+Space + |        Split side-by-side
Ctrl+Space + -        Split top/bottom
Ctrl+h/j/k/l          Navigate panes
Ctrl+Space + Ctrl+y   Git popup (Lazygit)
Ctrl+Space + Ctrl+j   Switch session (fzf)
Ctrl+Space + z        Zoom pane
Ctrl+Space + d        Detach session
```

#### Neovim:
```
<leader>e             File explorer
<leader>ff            Find files
<leader>fg            Search in files
gd                    Go to definition
K                     Show documentation
<leader>ca            Code actions
<leader>rn            Rename symbol
Alt+L                 Accept Copilot
<leader>cc            Copilot Chat
<leader>db            Debug breakpoint
<leader>gg            Lazygit
```

## Tips

### tmux:
- Use popup windows (`Ctrl+Space+Ctrl+y/d/t`) for quick tasks
- Detach sessions (`Prefix+d`) to keep work running
- Rename sessions (`Prefix+$`) for easy identification
- Use zoom (`Prefix+z`) to focus on one pane
- Mouse works for everything - click, drag, scroll

### Neovim:
- `Ctrl+o` and `Ctrl+i` to jump back/forward
- `gf` to open file under cursor
- Use `.` to repeat last action
- Visual block mode (`Ctrl+v`) for column editing
- `:%s/old/new/g` for find and replace

### Workflow:
- Keep one tmux session per project
- Use popups for quick git/docker checks
- Split terminal panes for logs/tests while coding
- Use `Ctrl+h/j/k/l` to move everywhere seamlessly
- Leverage Copilot Chat (`<leader>cc`) for questions

## Resources

### Documentation:
- [tmux man page](https://man.openbsd.org/tmux)
- [Neovim documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)

### Getting Help:
- tmux: `Prefix + ?` (list all keybindings)
- Neovim: `:help` or `:Telescope help_tags`
- Check plugin docs: `:Lazy` then press `?`

## Project Structure

```
~/.config/nvim/
└── init.lua           # Complete Neovim configuration

~/.tmux.conf           # tmux configuration
~/.zshrc               # Shell configuration with aliases

~/.tmux/plugins/       # tmux plugins (auto-installed)
```

## License

This configuration is free to use and modify as you wish.

## Credits

Built with amazing open-source tools:
- Neovim and the plugin ecosystem
- tmux and TPM
- Catppuccin theme
- All plugin authors who make this possible
