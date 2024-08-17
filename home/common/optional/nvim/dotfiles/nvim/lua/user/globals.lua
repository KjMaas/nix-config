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

require("which-key").add({
  { "<leader>o", group = "Toggle Options", nowait = true, remap = false },
  {
    "<leader>ol",
    "<cmd>set list!<cr>",
    desc = "Toggle eol, tab and space chars ON/OFF",
  },
  {
    "<leader>ot",
    "<cmd>lua toggle_tab_experience()<CR>",
    desc = "Toggle tabulations / convert to spaces",
  },
})
