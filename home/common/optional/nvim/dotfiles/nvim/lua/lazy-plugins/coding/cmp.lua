return {
  {
    "hrsh7th/nvim-cmp",

    version = false, -- last release is way too old
    event = { "InsertEnter", "CmdlineEnter" },

    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "FelipeLema/cmp-async-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "SirVer/ultisnips",
      "saadparwaiz1/cmp_luasnip",
      "f3fora/cmp-spell",
    },
    config = function()
      -- Set up nvim-cmp.
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local mappings = {
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.scroll_docs(-4),
        ["<C-n>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-c>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
      }

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert(mappings),
        completion = {
          keyword_length = 1,
          max_item_count = 5,
          keyword_pattern = ".*",
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", keyword_length = 1 },
          { name = "luasnip", keyword_length = 2 },
          { name = "async_path", keyword_length = 1 },
          { name = "buffer", keyword_length = 5 },
          { name = "spell", keyword_length = 5 },
          { name = "calc", keyword_length = 2 },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("config.presets").icons.kinds
            if icons[item.kind] then item.kind = icons[item.kind] .. item.kind end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "async_path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,

    init = function()
      vim.api.nvim_create_user_command("CmpDisable", function()
        require("cmp").setup.buffer({ enabled = false })
        print("cmp disabled")
      end, {})

      vim.api.nvim_create_user_command("CmpEnable", function()
        require("cmp").setup.buffer({ enabled = true })
        print("cmp enabled")
      end, {})

      require("which-key").register({
        ["<C-l>"] = { "<cmd>CmpEnable<cr>", "Turn Autocomplete ON" },
        ["<C-h>"] = { "<cmd>CmpDisable<cr>", "Turn Autocomplete OFF" },
      }, {
        mode = "i",
        prefix = "",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false,
      })
    end,
  },
}
