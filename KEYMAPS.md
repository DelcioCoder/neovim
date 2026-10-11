# 📝 Keymaps Neovim – Estilo ThePrimeagen

Este documento descreve todos os atalhos que já estão configurados na minha instalação Neovim com Lazy.nvim, Harpoon, Telescope, NvimTree e LSP/autocomplete.  

Todos os atalhos usam **`<leader>`** como **espaço**, e outros são baseados no estilo do Primeagen.

---

## 1️⃣ Ficheiros e busca (Telescope, Explorer, NvimTree)

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `<leader>pv` | `:Ex` | Abre o explorador de arquivos do Vim (netrw) |
| `<leader>pf` | `Telescope find_files` | Buscar arquivos no projeto |
| `<C-p>` | `Telescope git_files` | Buscar só arquivos versionados no git (precisa de um repositório) |
| `<leader>ps` | `Telescope live_grep` | Buscar texto em todos os arquivos |
| `<leader>e` | `NvimTreeToggle` | Abre ou fecha o File Tree |

---

## 2️⃣ Movimentação de linhas e scroll (Primeagen style)

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `J` (visual mode) | `:m '>+1<CR>gv=gv` | Move linha(s) selecionada(s) para baixo |
| `K` (visual mode) | `:m '<-2<CR>gv=gv` | Move linha(s) selecionada(s) para cima |
| `J` (normal mode) | `` mzJ`z `` | Junta a linha de baixo mantendo cursor na posição |
| `<C-d>` | `<C-d>zz` | Scroll down mantendo cursor centralizado |
| `<C-u>` | `<C-u>zz` | Scroll up mantendo cursor centralizado |

---

## 3️⃣ Paste inteligente

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `<leader>p` (visual mode) | `"_dP` | Cola sobre a seleção sem sobrescrever o register |

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

## 5️⃣ Navegação entre Splits

Não há atalhos próprios: usa-se o nativo do Vim.

| Tecla | Descrição |
|-------|-----------|
| `<C-w>h` / `<C-w>j` / `<C-w>k` / `<C-w>l` | Mover para o split à esquerda / abaixo / acima / à direita |

> `<C-h>` pertence ao Harpoon, por isso não há navegação estilo Tmux (`<C-h/j/k/l>`).

---

## 6️⃣ LSP (gopls, ts_ls, pyright)

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `<leader>f` | `vim.lsp.buf.format` | Formata o ficheiro (também acontece sozinho ao gravar) |
| `gd` | `vim.lsp.buf.definition` | Vai para a definição (`<C-o>` para voltar) |
| `K` | hover | Mostra a documentação do símbolo |
| `grn` | rename | Renomeia o símbolo |
| `gra` | code action | Ações de código |
| `grr` | references | Lista as referências |
| `gri` | implementation | Vai para a implementação |
| `gO` | document symbols | Lista os símbolos do ficheiro |
| `<C-s>` (insert mode) | signature help | Mostra a assinatura da função |

> `gd` e `<leader>f` são desta config; os restantes são defaults do Neovim 0.11 e só existem em buffers com LSP.

---

## 7️⃣ Autocomplete (nvim-cmp)

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `<C-Space>` | Completar | Abre menu de autocomplete |
| `<CR>` | Confirmar | Aceita a sugestão selecionada (a primeira, se nenhuma estiver escolhida) |
| `<C-n>` / `<C-p>` | Escolher | Próxima / anterior sugestão |
| `<C-y>` | Confirmar | Aceita a sugestão escolhida |
| `<C-e>` | Cancelar | Fecha o menu |

---

## 8️⃣ Go – abreviaturas automáticas

Só valem em ficheiros `.go`. Expandem ao digitar o caractere seguinte (espaço, Enter, `.`…).

| Digitar | Resultado | Quando |
|---------|-----------|--------|
| `main` | `package main` | `main` sozinho na linha e o ficheiro ainda não tem `package` |
| `fmt` | Acrescenta `import "fmt"` | Em código, se o ficheiro ainda não importa `fmt` |

> `func main()` continua normal. `fmt` dentro de strings, comentários ou como campo (`x.fmt`) não importa nada.

---

## 9️⃣ Comentários rápidos

| Tecla | Função | Descrição |
|-------|--------|-----------|
| `gcc` | `Comment.nvim` | Comenta/descomenta a linha atual |
| `gc` + movimento | `Comment.nvim` | Comenta/descomenta linhas (ex.: `gcap`), ou a seleção em visual mode |
| `gbc` / `gb` | `Comment.nvim` | O mesmo, com comentário de bloco |

---

## 🔟 Filosofia Primeagen resumida

- Leader key = `<space>`  
- Nunca tirar as mãos do teclado  
- Movimentos, edição e navegação otimizados para produtividade máxima  
- Harpoon + Telescope = navegação ultra rápida  
- Scroll e paste inteligentes para não quebrar fluxo de trabalho  

---

> 💡 Dica final: Usa o combo `<leader>pf` + Harpoon para abrir rapidamente o ficheiro que estás editando, navegar, e alternar entre funções sem tocar no mouse. Isso é o coração do workflow “Primeagen hardcore”.
