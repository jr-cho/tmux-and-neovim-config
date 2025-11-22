-- init.lua

-----------------------------------------------------------
-- Leader and Core Options
-----------------------------------------------------------
vim.g.mapleader = " "

-- Core options
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.swapfile = false

-- Better UI behavior
vim.o.cursorline = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.signcolumn = "yes"

-- Disable netrw (for nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-----------------------------------------------------------
-- Lazy.nvim Bootstrap
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------
require("lazy").setup({
  ---------------------------------------------------------
  -- Core dependencies
  ---------------------------------------------------------
  { "nvim-lua/plenary.nvim" },

  ---------------------------------------------------------
  -- Colorscheme: Catppuccin
  ---------------------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          treesitter = true,
          telescope = true,
          nvimtree = true,
          cmp = true,
          gitsigns = true,
          alpha = true,
          lsp_trouble = true,
          mason = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  ---------------------------------------------------------
  -- Telescope + FZF
  ---------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },

  ---------------------------------------------------------
  -- Treesitter
  ---------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "cpp",
          "python",
          "go",
          "lua",
          "bash",
          "json",
          "yaml",
          "markdown",
          "markdown_inline",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  ---------------------------------------------------------
  -- File Explorer: nvim-tree
  ---------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30, side = "left" },
        renderer = { group_empty = true },
        filters = {
          dotfiles = false,
        },
      })
    end,
  },

  ---------------------------------------------------------
  -- LSP, Mason, Completion
  ---------------------------------------------------------
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },

  -- Completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  ---------------------------------------------------------
  -- GitHub Copilot (ghost text + cmp integration)
  ---------------------------------------------------------
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  ---------------------------------------------------------
  -- UI: Alpha (Dashboard) + Lualine + Gitsigns
  ---------------------------------------------------------
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                           ",
        "       ██╗███████╗██████╗ ██╗ ██████╗██╗  ██╗ ██████╗       ",
        "       ██║██╔════╝██╔══██╗██║██╔════╝██║  ██║██╔═══██╗      ",
        "       ██║█████╗  ██████╔╝██║██║     ███████║██║   ██║      ",
        "  ██   ██║██╔══╝  ██╔══██╗██║██║     ██╔══██║██║   ██║      ",
        "  ╚█████╔╝███████╗██║  ██║██║╚██████╗██║  ██║╚██████╔╝      ",
        "   ╚════╝ ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝       ",
        "                                                           ",
        "                      J E R I C H O                        ",
        "                                                           ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "󰱼  Find text", ":Telescope live_grep<CR>"),
        dashboard.button("t", "󰙅  File tree", ":NvimTreeToggle<CR>"),
        dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
        dashboard.button("s", "  Restore Session", [[:lua require("persistence").load() <CR>]]),
        dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      local function footer()
        local stats = require("lazy").stats()
        local total_plugins = stats.count
        local datetime = os.date("  %d-%m-%Y   %H:%M:%S")
        local v = vim.version()
        local nvim_version = "   v" .. v.major .. "." .. v.minor .. "." .. v.patch
        return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version
      end

      dashboard.section.footer.val = footer()

      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"
      dashboard.section.footer.opts.hl = "Type"

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end,
  },

  -- Session management for Alpha button
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          section_separators = "",
          component_separators = "",
        },
      })
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  ---------------------------------------------------------
  -- Quality of Life: Comment, Autopairs, Toggleterm
  ---------------------------------------------------------
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
      -- integrate with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp_ok, cmp = pcall(require, "cmp")
      if cmp_ok then
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "float",
      })
    end,
  },
})

-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Basic
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Telescope
map("n", "<leader>f", ":Telescope find_files<CR>", opts)
map("n", "<leader>g", ":Telescope live_grep<CR>", opts)
map("n", "<leader>r", ":Telescope oldfiles<CR>", opts)

-- File tree
map("n", "<leader>t", ":NvimTreeToggle<CR>", opts)

-- System clipboard
map({ "n", "v" }, "<leader>y", '"+y', opts)
map({ "n", "v" }, "<leader>p", '"+p', opts)
map("n", "<leader>Y", '"+Y', opts)
map("n", "<leader>P", '"+P', opts)

-- LSP navigation (active when LSP attaches)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<leader>e", vim.diagnostic.open_float, opts)

-- Build / Run
map("n", "<F5>", ":w<CR>:!clang % -o %< && ./%<<CR>", opts) -- C/C++ compile + run
map("n", "<F6>", ":w<CR>:!uv run %<CR>", opts)              -- Python via uv

-----------------------------------------------------------
-- LSP + Mason + Completion (C, C++, Python, Go, Lua)
-----------------------------------------------------------
-- Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "pyright", "gopls", "lua_ls" },
})

-- nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- C / C++
lspconfig.clangd.setup({
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  capabilities = capabilities,
})

-- Python
lspconfig.pyright.setup({
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        typeCheckingMode = "basic",
      },
    },
  },
  before_init = function(_, config)
    local uv_venv = vim.fn.getcwd() .. "/.venv/bin/python"
    if vim.fn.executable(uv_venv) == 1 then
      config.settings.python.pythonPath = uv_venv
    end
  end,
})

-- Go
lspconfig.gopls.setup({
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
    },
  },
})

-- Lua (for Neovim config)
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-----------------------------------------------------------
-- Autoformat on Save (C, C++, Python, Go, Lua)
-----------------------------------------------------------
local format_grp = vim.api.nvim_create_augroup("LspFormatOnSave", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_grp,
  pattern = { "*.c", "*.h", "*.cpp", "*.hpp", "*.py", "*.go", "*.lua" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-----------------------------------------------------------
-- Small QoL Autocmds
-----------------------------------------------------------
-- Open nvim-tree when starting with a directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if directory then
      vim.cmd.cd(data.file)
      require("nvim-tree.api").tree.open()
    end
  end,
})
