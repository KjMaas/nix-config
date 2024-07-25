return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local status_ok, null_ls = pcall(require, "null-ls")
      if not status_ok then return end

      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        debug = false,

        sources = {
          null_ls.builtins.completion.spell,
          null_ls.builtins.diagnostics.shellcheck.with({
            diagnostic_config = {
              -- see :help vim.diagnostic.config()
              underline = true,
              virtual_text = true,
              signs = true,
              update_in_insert = false,
              severity_sort = true,
            },
          }),
        },
      })
    end,

    init = function()
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
        print("there's an issue with which-key - Null-ls")
        return
      end

      require("which-key").add({
        { "<leader>n", group = "Null-ls", nowait = true, remap = false },
        {
          "<leader>ni",
          "<cmd>NullLsInfo<CR>",
          desc = "Null-ls info",
        },
        {
          "<leader>ns",
          "<cmd>ToggleSpell<CR>",
          desc = "Toggle Spelling ON/OFF",
        },
      })
    end,
  },
}
