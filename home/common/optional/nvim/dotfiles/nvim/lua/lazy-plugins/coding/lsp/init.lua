return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local handlers = require("lazy-plugins.coding.lsp.handlers")
      handlers.setup()

      require("lspconfig").lua_ls.setup({
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
      })
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

  require("lazy-plugins.coding.lsp.python"),

  -- TODO: find another plugin to check spelling
  require("lazy-plugins.coding.lsp.null-ls"),
}
