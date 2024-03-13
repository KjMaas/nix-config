-- -- Register mappings with which-key
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print("there's an issue with which-key - Options")
  return
end

vim.g.tab_experience = false
function _G.toggle_tab_experience()
  vim.o.tabstop = 4

  if vim.g.tab_experience then
    vim.o.expandtab = false
    vim.o.softtabstop = 4
    vim.o.shiftwidth = 4
  else
    vim.o.expandtab = true
    vim.o.softtabstop = 2
    vim.o.shiftwidth = 2
  end
  vim.g.tab_experience = not vim.g.tab_experience
end

local mappings = {

  o = {
    name = "Toggle Option",
    l = { "<cmd>set list!<cr>", "Toggle eol, tab and space chars ON/OFF" },
    t = { "<cmd>lua toggle_tab_experience()<CR>", "Toggle tabulations / convert to spaces" },
  },
}

local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

which_key.register(mappings, opts)
