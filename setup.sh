#!/bin/bash

echo "🚀 Instalando dependências..."
sudo apt update
sudo apt install -y neovim git curl build-essential xclip ripgrep fd-find nodejs npm

# Corrigir nome do fd (Ubuntu)
ln -sf $(which fdfind) ~/.local/bin/fd

# Instalar lazy.nvim
echo "📦 Instalando lazy.nvim..."
git clone https://github.com/folke/lazy.nvim.git --depth=1 ~/.local/share/nvim/lazy/lazy.nvim

# Criar estrutura
mkdir -p ~/.config/nvim/lua/config
mkdir -p ~/.config/nvim/lua/plugins

# ========================
# init.lua
# ========================
cat <<EOF > ~/.config/nvim/init.lua
require("config.settings")
require("config.keymaps")
require("config.lazy")
EOF

# ========================
# settings.lua
# ========================
cat <<EOF > ~/.config/nvim/lua/config/settings.lua
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.g.mapleader = " "
EOF

# ========================
# keymaps.lua (ESTILO PRIMEAGEN)
# ========================
cat <<EOF > ~/.config/nvim/lua/config/keymaps.lua
local keymap = vim.keymap.set

-- Explorer
keymap("n", "<leader>pv", vim.cmd.Ex)

-- Move linhas
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Mantém cursor centrado
keymap("n", "J", "mzJ\`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Melhor paste
keymap("x", "<leader>p", "\"_dP")

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")

-- Nvim Tree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
EOF

# ========================
# lazy.lua
# ========================
cat <<EOF > ~/.config/nvim/lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Tema
    { "folke/tokyonight.nvim", config = function()
        vim.cmd.colorscheme("tokyonight")
    end },

    -- Telescope
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
        end
    },

    -- File tree
    { "nvim-tree/nvim-tree.lua" },

    -- LSP
    { "neovim/nvim-lspconfig" },

    -- Autocomplete
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        }
    },

    -- Comentários
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },
})
EOF

# ========================
# LSP config
# ========================
cat <<EOF >> ~/.config/nvim/lua/config/lazy.lua

-- LSP Setup
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.gopls.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({ capabilities = capabilities })
lspconfig.pyright.setup({ capabilities = capabilities })
EOF

# ========================
# CMP config
# ========================
cat <<EOF >> ~/.config/nvim/lua/config/lazy.lua

local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = "nvim_lsp" }
    }
})
EOF

echo "✅ Setup concluído!"
echo "👉 Abre o nvim e deixa o lazy instalar tudo automaticamente"
