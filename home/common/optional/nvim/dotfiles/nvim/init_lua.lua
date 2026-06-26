vim.env.MYVIMRC = "~/.config/nvim/init.lua"

-- Setup all the stuff you can do with native Neovim
require("config.keymaps")
require("config.options")
require("config.lsp")

-- Manage external plugins with lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config.lazy")

-- Load user globals (can use plugins)
require("user.globals")
require("user.filetypes")

-- Load colorscheme
local presets = require("config.presets")
presets.set_colorscheme("tokyonight-moon")
