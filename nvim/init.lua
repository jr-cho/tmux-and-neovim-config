-- Core Neovim options
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.swapfile = false

-- Bootstrap lazy.nvim if it's not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Configure plugins with lazy-loading for fast startup
require("lazy").setup({
    -- Core dependencies
    { "nvim-lua/plenary.nvim",   lazy = false },
    { "williamboman/mason.nvim", lazy = false, config = true },

    -- Language Server Protocol (LSP) and autocompletion setup.
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            local lsp = require("lspconfig")
            local mason_lsp = require("mason-lspconfig")
            local cap = require("cmp_nvim_lsp").default_capabilities()

            mason_lsp.setup({
                ensure_installed = { "clangd", "rust_analyzer", "gopls", "lua_ls" },
                automatic_installation = true,
            })

            lsp.clangd.setup({ capabilities = cap, cmd = { "clangd", "--background-index", "--clang-tidy" } })
            lsp.rust_analyzer.setup({
                capabilities = cap,
                settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } },
            })
            lsp.gopls.setup({
                capabilities = cap,
                settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true, gofumpt = true } },
            })
            lsp.lua_ls.setup({
                capabilities = cap,
                settings = { Lua = { runtime = { version = "LuaJIT" }, diagnostics = { globals = { "vim" } }, telemetry = { enable = false } } },
            })
        end
    },

    -- Treesitter for advanced syntax highlighting and indentation.
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "cpp", "rust", "go", "lua", "vim" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

    -- Autocompletion and snippets. Loaded when entering Insert mode.
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            cmp.setup({
                snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end),
                }),
                sources = { { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" }, { name = "path" } },
            })
        end
    },

    -- File finding and searching
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    layout_strategy = "vertical",
                    layout_config = {
                        prompt_position = "top",
                        width = 0.8,
                        height = 0.8,
                    },
                },
            })
            -- FOR YOU REINALDO
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
        end
    },

    -- Auto-formatting on save
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    c = { "clang_format" },
                    cpp = { "clang_format" },
                    rust = { "rustfmt" },
                    go = { "goimports", "gofmt" },
                    lua = { "stylua" },
                },
                format_on_save = { timeout_ms = 500, lsp_fallback = true },
            })
            vim.keymap.set("n", "<leader>f",
                function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Format File" })
        end
    },

    -- Theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = false,
                integrations = {
                    cmp = true, gitsigns = true, telescope = true, treesitter = true, mason = true,
                },
            })
            vim.cmd.colorscheme("catppuccin-mocha")
        end
    },

    -- Optional: A convenience plugin for keymap hints
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup()
        end
    }

}, {
    defaults = { lazy = true },
    performance = {
        rtp = { disabled_plugins = { "gzip", "matchit", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" } }
    }
})

-- Keymaps that don't belong to a specific plugin
vim.keymap.set("i", "jk", "<Esc>", { desc = "Fast Escape" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear Highlighted Search" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("v", "<", "<gv", { desc = "Decrease Indent" })
vim.keymap.set("v", ">", ">gv", { desc = "Increase Indent" })

-- Autocommands
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local save = vim.fn.winsaveview()
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.winrestview(save)
    end,
    desc = "Remove Trailing Whitespace on Save"
})

-- Fixes the deprecated highlight warning
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
    desc = "Highlight on Yank"
})

-- LSP Keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end,
    desc = "LSP Keymaps"
})
