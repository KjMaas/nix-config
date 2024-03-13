-- stylua: ignore start

-- Visual
vim.o.conceallevel       = 0       -- Don't hide quotes in markdown
vim.o.cmdheight          = 1
vim.o.pumheight          = 10
vim.o.showmode           = false
vim.o.showtabline        = 2       -- Always show tabline
vim.o.title              = true
vim.o.termguicolors      = true    -- Use true colors, required for some plugins
vim.wo.number            = true
vim.wo.relativenumber    = true
vim.wo.signcolumn        = 'number'
vim.wo.cursorline        = true

-- Behaviour
vim.opt.list             = false
vim.opt.listchars        = { space = '_', tab = '>--', eol = '↵' }
vim.o.hlsearch           = true
vim.o.ignorecase         = true    -- Ignore case when using lowercase in search
vim.o.smartcase          = true    -- But don't ignore it when using upper case
vim.o.smarttab           = true
vim.o.smartindent        = true
vim.o.expandtab          = true    -- Convert tabs to spaces.
vim.o.tabstop            = 4
vim.o.softtabstop        = 2
vim.o.shiftwidth         = 2
vim.o.splitbelow         = true
vim.o.splitright         = true
vim.o.scrolloff          = 12      -- Minimum offset in lines to screen borders
vim.o.sidescrolloff      = 8
vim.o.mouse              = 'a'

-- Vim specific
vim.o.hidden             = true    -- Do not save when switching buffers
vim.o.fileencoding       = "utf-8"
vim.o.spelllang          = "en_us,fr,nl" -- https://ftp.nluug.nl/pub/vim/runtime/spell/
vim.o.completeopt        = "menuone,noinsert,noselect"
vim.o.wildmode           = "longest,full"  -- Display auto-complete in Command Mode
vim.o.updatetime         = 300     -- Delay until write to Swap and HoldCommand event
vim.g.do_file_type_lua   = 1
-- Undo files
vim.o.undofile           = true

-- Disable default plugins
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- timeout for mapped sequence completion
vim.o.timeoutlen         = 500
vim.api.nvim_create_autocmd("BufEnter", {
  -- pattern = "*",
  callback = function ()
    if (vim.bo.filetype == "nnn") then
      vim.o.timeoutlen = 10
    end
  end
})
vim.api.nvim_create_autocmd("BufLeave", {
  -- pattern = "*",
  callback = function ()
    if (vim.bo.filetype == "nnn") then
      vim.o.timeoutlen = 500
    end
  end
})

-- Set clipboard to use system clipboard
vim.o.clipboard = "unnamedplus"

-- stylua: ignore end
