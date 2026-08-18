return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- master is unmaintained and incompatible with Neovim >= 0.12; main is a
    -- full incompatible rewrite (no more `nvim-treesitter.configs`, no
    -- `playground`/`incremental_selection` modules).
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
    },

    config = function()
      -- use markdown syntax highlighting for .mdx files
      vim.treesitter.language.register("markdown", "mdx")

      require("ts_context_commentstring").setup({
        enable = true,
        enable_autocmd = false,

        config = {
          javascript = {
            __default = "// %s",
            statement_block = "{/* %s */}",
            jsx_element = "{/* %s */}",
            jsx_fragment = "{/* %s */}",
            jsx_attribute = "// %s",
            comment = "// %s",
            ERROR = "{/* %s */}",
          },
        },
      })

      require("nvim-ts-autotag").setup()

      local ensure_installed = {
        "bash",
        "c",
        "html",
        "http",
        "javascript",
        "json",
        "lua",
        "nix",
        "python",
        "query",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      }
      require("nvim-treesitter").install(ensure_installed)

      -- enable highlighting + indentation, auto-installing parsers for any
      -- other filetype encountered along the way
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          local ts = require("nvim-treesitter")
          if lang and not vim.tbl_contains(ts.get_installed("parsers"), lang) and vim.tbl_contains(ts.get_available(), lang) then
            ts.install({ lang }):wait(60000)
          end

          pcall(vim.treesitter.start)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
