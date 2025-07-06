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

local spell_active = false
vim.api.nvim_create_user_command("ToggleSpell", function(args)
  spell_active = not spell_active
  if spell_active then
    vim.api.nvim_echo({ { "Spelling ON" } }, false, {})
    vim.o.spell = true
  else
    vim.api.nvim_echo({ { "Spelling OFF" } }, false, {})
    vim.o.spell = false
  end
end, {
    desc = "Toggle Spelling ON/OFF",
    bang = true,
  })


-- Register mappings with which-key
local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  print("there's an issue with which-key - in globals.lua")
  return
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

  {
    "<leader>ns",
    "<cmd>ToggleSpell<CR>",
    desc = "Toggle Spelling ON/OFF",
  },
})
