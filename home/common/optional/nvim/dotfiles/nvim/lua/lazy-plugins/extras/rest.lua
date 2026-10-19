local rest_filetypes = { "http" }
return {
  -- HTTP REST-Client Interface
  "rest-nvim/rest.nvim",
  -- Backup for kulala.nvim (see kulala.lua); to switch, remove this and set
  -- `enabled = false` in kulala.lua, then run `:Lazy build rest.nvim`.
  enabled = false,
  ft = rest_filetypes,
  -- lazy's default rockspec build fails on NixOS: the nix-wrapped luarocks can't
  -- load the `treesitter-parser` build backend needed by the tree-sitter-http rock.
  -- The http parser comes from nvim-treesitter instead, so only install the
  -- pure-Lua rocks into the tree lazy adds to package.path for this plugin.
  build = function(plugin)
    local root = require("lazy.core.config").options.rocks.root .. "/" .. plugin.name
    for _, rock in ipairs({ "nvim-nio", "mimetypes", "xml2lua", "fidget.nvim" }) do
      local res = vim.system({ "luarocks", "--tree", root, "--lua-version", "5.1", "install", rock }):wait()
      if res.code ~= 0 then error(("luarocks install %s failed:\n%s"):format(rock, res.stderr)) end
    end
  end,
  init = function()
    ---@type rest.Opts
    vim.g.rest_nvim = {
      response = {
        hooks = {
          -- format the response body using `gq`
          format = true,
        },
      },
      ui = {
        keybinds = {
          -- cycle through the result panes (body/headers/cURL/stats)
          prev = "H",
          next = "L",
        },
      },
    }
  end,
  keys = {
    { "<CR>", "<cmd>Rest run<cr>", desc = "Run request under cursor", ft = rest_filetypes },
    { "<leader>kr", "<cmd>Rest last<cr>", desc = "Replay the last request", ft = rest_filetypes },
    { "<leader>ko", "<cmd>Rest open<cr>", desc = "Open result pane", ft = rest_filetypes },
    { "<leader>kc", "<cmd>Rest curl yank<cr>", desc = "Copy as cURL", ft = rest_filetypes },
    { "<leader>kC", "<cmd>Rest curl comment<cr>", desc = "Insert cURL as comment", ft = rest_filetypes },
    { "<leader>ke", "<cmd>Rest env select<cr>", desc = "Select environment", ft = rest_filetypes },
    { "<leader>kE", "<cmd>Rest env show<cr>", desc = "Show environment", ft = rest_filetypes },
    { "<leader>kl", "<cmd>Rest logs<cr>", desc = "Open logs", ft = rest_filetypes },
    { "<leader>kK", "<cmd>Rest cookies<cr>", desc = "Edit cookies", ft = rest_filetypes },
  },
}
