-- General keymaps

local Utils = require("user.utils")
local opts = Utils.opts

local map = vim.keymap.set
local cmd = vim.cmd

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Reload configuration files
map(
  "n",
  "<leader>r",
  ':source $MYVIMRC<CR> :lua vim.notify(vim.env.MYVIMRC .. "  sourced!", "info", {title=":source $MYVIMRC"})<CR>',
  opts("reload NeoVim config.")
)

-- jk kj to normal mode
map("i", "jk", "<Esc>", opts("return to normal mode"))
map("i", "kj", "<Esc>", opts("return to normal mode"))
-- new line in insert mode without triggering a linebreak at current position
map("i", "<c-cr>", "<Esc>o", opts("new line without line break"))
-- scroll through wrapped lines
map("n", "j", "gj", opts(""))
map("n", "k", "gk", opts(""))
-- move lines up or down
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts("move line down"))
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts("move line up"))
map("n", "<A-j>", ":m .+1<CR>==", opts("move line down"))
map("n", "<A-k>", ":m .-2<CR>==", opts("move line up"))
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts("move line down"))
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts("move line up"))

-- Terminal window navigation
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  map("t", "jk", [[<C-\><C-n>]], opts)
  map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>", opts("Increase window width"))
map("n", "<C-Down>", ":resize -2<CR>", opts("Decrease window width"))
map("n", "<C-Left>", ":vertical resize -2<CR>", opts("Increase window height"))
map("n", "<C-Right>", ":vertical resize +2<CR>", opts("Decrease window height"))
map("i", "<C-Up>", "<Esc>:resize +2<CR>", opts("Increase window width"))
map("i", "<C-Down>", "<Esc>:resize -2<CR>", opts("Decrease window width"))
map("i", "<C-Left>", "<Esc>:vertical resize -2<CR>", opts("Increase window height"))
map("i", "<C-Right>", "<Esc>:vertical resize +2<CR>", opts("Decrease window height"))
map("v", "<C-Up>", "<Esc>:resize +2<CR>gv", opts("Increase window width"))
map("v", "<C-Down>", "<Esc>:resize -2<CR>gv", opts("Decrease window width"))
map("v", "<C-Left>", "<Esc>:vertical resize -2<CR>gv", opts("Increase window height"))
map("v", "<C-Right>", "<Esc>:vertical resize +2<CR>gv", opts("Decrease window height"))

-- Save with Ctrl + S
map("i", "<C-s>", "<Esc>:w<CR>", opts("save"))
map("n", "<C-s>", ":w<CR>", opts("save"))

-- Close Window
map("n", "<C-q>", "<C-w>c", opts("close window"))

-- Move around windows
map("n", "<C-h>", "<C-w>h", opts(""))
map("n", "<C-j>", "<C-w>j", opts(""))
map("n", "<C-k>", "<C-w>k", opts(""))
map("n", "<C-l>", "<C-w>l", opts(""))

-- Populate substitution
map("n", "<leader>s", ":s//g<Left><Left>", opts(""))
map("n", "<leader>S", ":%s//g<Left><Left>", opts(""))
map("n", "<leader><C-s>", ":%s//gc<Left><Left><Left>", opts(""))

map("v", "<leader>s", ":s//g<Left><Left>", opts(""))
map("v", "<leader><A-s>", ":%s//g<Left><Left>", opts(""))
map("v", "<leader>S", ":%s//gc<Left><Left><Left>", opts(""))

--------------------------------------------------------
-- useful ressource about vim registers:
-- https://blog.sanctum.geek.nz/advanced-vim-registers/
--------------------------------------------------------
-- Copy to system clipboard
map("n", "<leader>y", '"+y', opts("Copy to system clipboard"))
map("v", "<leader>y", '"+y', opts("Copy to system clipboard"))
-- Paste from system clipboard
map("n", "<leader><C-v>", '"+p', opts("Paste from system clipboard"))
map("v", "<leader><C-v>", '"+p', opts("Paste from system clipboard"))
-- Paste from cursor to end of line (overwriting the content that was already there)
map("n", "<C-p>", 'v$h"+pg,', opts("Paste from system clipboard - overwrite"))
map("v", "<C-p>", '$h"+pg,', opts("Paste from system clipboard - overwrite"))
map("n", "<C-A-p>", 'v$h"_d"+pg,', opts("Paste from system clipboard - overwrite - no copy"))
map("v", "<C-A-p>", '$h"_d"+pg,', opts("Paste from system clipboard - overwrite - no copy"))

-- Open file path below cursor in default application (requires mimeo)
map("n", "<leader>xo", 'yiW:!mimeo <c-r>" &<CR><CR>', opts("open in default app"))

-- ToDo: prevent command being executed if content is not json
-- Prettify/Minify json (requires jq)
map("n", "<leader>j", ":%!jq . <CR>", opts("Prettify json (entire file)"))
map("n", "<leader>J", ":%!jq -c . <CR>", opts("Minify json (entire file)"))
map("v", "<leader>j", ":'<,'>!jq . <CR>", opts("Prettify json (visual selection)"))
map("v", "<leader>J", ":'<,'>!jq -c . <CR>", opts("Minify json (visual selection)"))
