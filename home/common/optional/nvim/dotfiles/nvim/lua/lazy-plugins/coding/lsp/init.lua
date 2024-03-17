return {
  {
    "neovim/nvim-lspconfig",
    dependencies = "folke/neodev.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local handlers = require("lazy-plugins.coding.lsp.handlers")
      handlers.setup()

      local servers = require("config.languages.defaults").servers
      for _, server in pairs(servers) do
        local opts = {
          on_attach = handlers.on_attach,
          capabilities = handlers.capabilities,
        }
        local require_ok, settings = pcall(require, "config.languages." .. server)
        if require_ok then opts = vim.tbl_deep_extend("force", settings, opts) end
        if server == "lua_ls" then require("neodev").setup({}) end

        lspconfig[server].setup(opts)
      end
    end,

    init = function()
      local diagnostics_active = false
      function _G.toggle_diagnostics_virtual_text()
        diagnostics_active = not diagnostics_active
        if diagnostics_active then
          vim.api.nvim_echo({ { "Show diagnostics" } }, false, {})
          vim.diagnostic.config({ virtual_text = true })
        else
          vim.api.nvim_echo({ { "Disable diagnostics" } }, false, {})
          vim.diagnostic.config({ virtual_text = false })
        end
      end

      -- Register mappings with which-key
      local status_ok, which_key = pcall(require, "which-key")
      if not status_ok then
        print("there's an issue with which-key - LSP")
        return
      end

      local mappings = {
        l = {
          name = "LSP",
          D = {
            "<cmd>call v:lua.toggle_diagnostics_virtual_text()<CR>",
            "toggle in-line diagnostics",
          },
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
    end,
  },

  -- TODO: find another plugin to check spelling
  require("lazy-plugins.coding.lsp.null-ls"),
}
