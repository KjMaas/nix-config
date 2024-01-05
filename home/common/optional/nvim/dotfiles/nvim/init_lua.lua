vim.env.MYVIMRC = "~/.config/nvim/init.lua"


-- local transparent_window = true
vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha

local modules = {
  'user.utils',
  'user.options',
  'user.plugins',
  'user.keymaps',
  'user.filetypes',

  'plugins.barbar',
  'plugins.comment',
  'plugins.gitsigns',
  'plugins.colorizer',
  'plugins.lightspeed',
  'plugins.lualine',
  'plugins.project',

  'plugins.treesitter',
  'plugins.markdown-preview',

  'plugins.lsp',
  'plugins.dap',
  'plugins.cmp',
  'plugins.luasnip',
  'plugins.formatter',
  'plugins.codeium',

  'plugins.nnn',
  'plugins.nvimtree',
  'plugins.telescope',
  'plugins.toggleterm',
  'plugins.notify',
  'plugins.registers',

  'plugins.which-key',

  'user.pdexp.export_to_pdf',

  'user.colorscheme',
}


for _, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end

-- local Utils = require('user.utils')
-- if transparent_window then
--   Utils.enable_transparent_mode()
-- end

-- vim.cmd [[colorscheme catppuccin]]
