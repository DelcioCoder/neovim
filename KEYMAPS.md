# 📝 Keymaps Neovim – Estilo ThePrimeagen

Este documento descreve todos os atalhos que já estão configurados na minha instalação Neovim com Lazy.nvim, Harpoon, Telescope, NvimTree e LSP/autocomplete.  

Todos os atalhos usam **`<leader>`** como **espaço**, e outros são baseados no estilo do Primeagen.

---

## 1️⃣ Leader básico

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `<leader>pv` | `:Ex` | Abre o explorador de arquivos do Vim (Explorer) |
| `<leader>ff` | `Telescope find_files` | Buscar arquivos no projeto |
| `<leader>fg` | `Telescope live_grep` | Buscar texto em todos os arquivos |
| `<leader>e` | `NvimTreeToggle` | Abre ou fecha o File Tree |

---

## 2️⃣ Movimentação de linhas e scroll (Primeagen style)

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `J` (visual mode) | `:m '>+1<CR>gv=gv` | Move linha(s) selecionada(s) para baixo |
| `K` (visual mode) | `:m '<-2<CR>gv=gv` | Move linha(s) selecionada(s) para cima |
| `J` (normal mode) | `mzJ\`z` | Junta a linha de baixo mantendo cursor na posição |
| `<C-d>` | `<C-d>zz` | Scroll down mantendo cursor centralizado |
| `<C-u>` | `<C-u>zz` | Scroll up mantendo cursor centralizado |

---

## 3️⃣ Paste inteligente

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `<leader>p` (visual mode) | `" _ dP` | Cola sobre a seleção sem sobrescrever o register |

> Isso evita perder o conteúdo do último yanked.

---

## 4️⃣ Harpoon – Navegação rápida entre ficheiros

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `<leader>a` | `require("harpoon.mark").add_file()` | Adiciona o ficheiro atual ao Harpoon |
| `<C-e>` | `require("harpoon.ui").toggle_quick_menu()` | Mostra o menu do Harpoon com todos os ficheiros adicionados |
| `<C-h>` | `require("harpoon.ui").nav_file(1)` | Vai para o 1º ficheiro marcado |
| `<C-t>` | `require("harpoon.ui").nav_file(2)` | Vai para o 2º ficheiro marcado |
| `<C-n>` | `require("harpoon.ui").nav_file(3)` | Vai para o 3º ficheiro marcado |
| `<C-s>` | `require("harpoon.ui").nav_file(4)` | Vai para o 4º ficheiro marcado |

> ⚡ Use isso para trocar rapidamente entre ficheiros críticos sem abrir o explorer.

---

## 5️⃣ Navegação entre Splits e Tmux

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `<C-h>` | `:TmuxNavigateLeft<CR>` | Mover para o split à esquerda |
| `<C-j>` | `:TmuxNavigateDown<CR>` | Mover para o split abaixo |
| `<C-k>` | `:TmuxNavigateUp<CR>` | Mover para o split acima |
| `<C-l>` | `:TmuxNavigateRight<CR>` | Mover para o split à direita |

> Integrado com Tmux para navegação perfeita entre janelas.

---

## 6️⃣ Telescope (Busca avançada)

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `<leader>ff` | `Telescope find_files` | Buscar arquivos no projeto rapidamente |
| `<leader>fg` | `Telescope live_grep` | Buscar por palavras dentro de todos os arquivos |

> 🔥 Dica: combina com `<C-p>` no Harpoon para navegar ainda mais rápido.

---

## 7️⃣ NvimTree (File Tree)

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `<leader>e` | Toggle | Abrir/fechar árvore de arquivos |

> Útil para navegar rapidamente no projeto sem sair do Neovim.

---

## 8️⃣ Autocomplete e LSP (nvim-cmp + lspconfig)

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `<C-Space>` | Completar | Abre menu de autocomplete |
| `<CR>` | Confirmar | Aceita sugestão selecionada |

> Com LSP instalado (gopls, tsserver, pyright), tens autocompletar inteligente, diagnósticos e formatação automática.

---

## 9️⃣ Comentários rápidos

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `gc` | `Comment.nvim` | Comenta/descomenta linhas ou blocos |

> Funciona em visual e normal mode.

---

## 10️⃣ Filosofia Primeagen resumida

- Leader key = `<space>`  
- Nunca tirar as mãos do teclado  
- Movimentos, edição e navegação otimizados para produtividade máxima  
- Harpoon + Telescope = navegação ultra rápida  
- Scroll e paste inteligentes para não quebrar fluxo de trabalho  

---

> 💡 Dica final: Usa o combo `<leader>ff` + Harpoon para abrir rapidamente o ficheiro que estás editando, navegar, e alternar entre funções sem tocar no mouse. Isso é o coração do workflow “Primeagen hardcore”.

