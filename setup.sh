#!/bin/bash

echo "🚀 Instalando dependências..."
sudo apt update
sudo apt install -y neovim git curl build-essential xclip ripgrep fd-find nodejs npm

# Corrigir nome do fd (Ubuntu)
ln -sf $(which fdfind) ~/.local/bin/fd

# Servidores LSP (ts_ls, pyright, gopls)
echo "🧠 Instalando servidores LSP..."
npm install -g --prefix ~/.local typescript typescript-language-server pyright
if command -v go >/dev/null; then
    go install golang.org/x/tools/gopls@latest
fi

# Instalar lazy.nvim
echo "📦 Instalando lazy.nvim..."
git clone https://github.com/folke/lazy.nvim.git --depth=1 ~/.local/share/nvim/lazy/lazy.nvim

# Criar estrutura
mkdir -p ~/.config/nvim/lua/config
mkdir -p ~/.config/nvim/lua/plugins
mkdir -p ~/.config/nvim/after/ftplugin

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
keymap("x", "J", ":m '>+1<CR>gv=gv")
keymap("x", "K", ":m '<-2<CR>gv=gv")

-- Mantém cursor centrado
keymap("n", "J", "mzJ\`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Melhor paste
keymap("x", "<leader>p", "\"_dP")

-- Telescope
keymap("n", "<leader>pf", "<cmd>Telescope find_files<cr>")
keymap("n", "<C-p>", "<cmd>Telescope git_files<cr>")
keymap("n", "<leader>ps", "<cmd>Telescope live_grep<cr>")

-- Nvim Tree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

-- Formatar
keymap("n", "<leader>f", vim.lsp.buf.format)
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
    { "nvim-tree/nvim-tree.lua", config = true },

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
vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
vim.lsp.enable({ "gopls", "ts_ls", "pyright" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
    end,
})
EOF

# ========================
# CMP config
# ========================
cat <<EOF >> ~/.config/nvim/lua/config/lazy.lua

local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Sem menu aberto, <C-]> expande as abreviaturas antes do <CR>
        ['<CR>'] = function()
            if not cmp.confirm({ select = true }) then
                vim.api.nvim_feedkeys(vim.keycode("<C-]><CR>"), "nti", false)
            end
        end,
    }),
    sources = {
        { name = "nvim_lsp" }
    }
})
EOF

# ========================
# Formatar ao gravar
# ========================
cat <<EOF >> ~/.config/nvim/lua/config/lazy.lua

-- Formatar ao gravar
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        local clients = vim.lsp.get_clients({ bufnr = args.buf })
        for _, client in ipairs(clients) do
            if client:supports_method("textDocument/formatting") then
                vim.lsp.buf.format({ bufnr = args.buf })
                return
            end
        end
    end,
})
EOF

# ========================
# Go: abreviaturas "main" e "fmt"
# ========================
cat <<'EOF' > ~/.config/nvim/after/ftplugin/go.lua
-- Abreviaturas de Go (só valem em buffers .go)

-- "main" sozinho na linha, num ficheiro ainda sem package -> "package main"
vim.keymap.set("ia", "main", function()
    local sozinho = vim.api.nvim_get_current_line():match("^%s*main$")
    if sozinho and vim.fn.search([[^package\s]], "nw") == 0 then
        return "package main"
    end
    return "main"
end, { buffer = true, expr = true })

-- Acrescenta import "fmt" se o ficheiro ainda não o tiver
local function importa_fmt(buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local pkg, bloco, ultimo, spec
    local no_bloco = false

    for i, l in ipairs(lines) do
        if no_bloco then
            if l:find('"fmt"', 1, true) then return end
            if l:match("^%s*%)") then no_bloco = false end
        elseif l:match("^import%s*%(") and not l:find(")", 1, true) then
            bloco, no_bloco = i, true
        elseif l:match("^import%s") then
            if l:find('"fmt"', 1, true) then return end
            ultimo, spec = i, l:match("^import%s+(.*)$")
        elseif l:match("^package%s") then
            pkg = i
        end
    end

    if bloco then
        vim.api.nvim_buf_set_lines(buf, bloco, bloco, false, { '\t"fmt"' })
    elseif ultimo and spec:sub(1, 1) ~= "(" then
        -- import simples passa a bloco
        vim.api.nvim_buf_set_lines(buf, ultimo - 1, ultimo, false, { "import (", '\t"fmt"', "\t" .. spec, ")" })
    elseif ultimo then
        vim.api.nvim_buf_set_lines(buf, ultimo, ultimo, false, { 'import "fmt"' })
    elseif pkg then
        local novo = { "", 'import "fmt"' }
        if lines[pkg + 1] and lines[pkg + 1] ~= "" then table.insert(novo, "") end
        vim.api.nvim_buf_set_lines(buf, pkg, pkg, false, novo)
    else
        vim.api.nvim_buf_set_lines(buf, 0, 0, false, { 'import "fmt"', "" })
    end
end

-- "fmt" em código (não em strings, comentários ou campos x.fmt) -> importa a lib
vim.keymap.set("ia", "fmt", function()
    local antes = vim.api.nvim_get_current_line():sub(1, vim.fn.col(".") - 1)
    local _, aspas = antes:gsub('"', "")
    local em_codigo = aspas % 2 == 0
        and not antes:find("//", 1, true)
        and not antes:find("`", 1, true)
        and antes:sub(-4, -4) ~= "."

    if em_codigo then
        local buf = vim.api.nvim_get_current_buf()
        vim.schedule(function() importa_fmt(buf) end)
    end
    return "fmt"
end, { buffer = true, expr = true })
EOF

echo "✅ Setup concluído!"
echo "👉 Abre o nvim e deixa o lazy instalar tudo automaticamente"
