return {
  {
    "lewis6991/gitsigns.nvim", -- Git support (like showing which lines are added or removed)
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      -- Configs for gitsigns plugin
      local status_ok, gitsigns = pcall(require, "gitsigns")
      if not status_ok then return end

      gitsigns.setup({

        signs = {
          add = {
            text = "▎",
          },
          change = {
            text = "▎",
          },
          delete = {
            text = "▎",
          },
          topdelete = {
            text = "--",
          },
          changedelete = {
            text = "▎",
          },
        },

        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`

        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },

        attach_to_untracked = true,

        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },

        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,

        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })

      require("which-key").add({
        {
          "<leader>fB",
          "<cmd>Telescope git_branches<cr>",
          desc = "Checkout Branch",
        },
        {
          "<leader>fO",
          "<cmd>Telescope git_status<cr>",
          desc = "Open changed file",
        },
        {
          "<leader>fC",
          "<cmd>Telescope git_commits<cr>",
          desc = "Checkout Commit",
        },
        { "<leader>g", group = "Git", nowait = true, remap = false },
        { "<leader>gC", "<cmd>Git commit<cr>", desc = "Commit" },
        { "<leader>gD", "<cmd>Gvdiffsplit<cr>", desc = "Diff" },
        { "<leader>gL", "<cmd>Git blame<cr>", desc = "Blame File" },
        {
          "<leader>gR",
          "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
          desc = "Reset Buffer",
        },
        {
          "<leader>gb",
          "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>",
          desc = "Toggle Current Line Blame",
        },
        {
          "<leader>gd",
          "<cmd>lua require 'gitsigns'.toggle_deleted()<cr>",
          desc = "Toggle Deleted Hunk",
        },
        {
          "<leader>gh",
          "<cmd>lua require 'gitsigns'.toggle_signs()<cr>",
          desc = "Toggle Signs",
        },
        {
          "<leader>gj",
          "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
          desc = "Next Hunk",
        },
        {
          "<leader>gk",
          "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
          desc = "Previous Hunk",
        },
        {
          "<leader>gl",
          "<cmd>lua require 'gitsigns'.blame_line()<cr>",
          desc = "Blame Line",
        },
        {
          "<leader>gp",
          "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
          desc = "Preview Hunk",
        },
        {
          "<leader>gr",
          "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
          desc = "Reset Hunk",
        },
        {
          "<leader>gs",
          "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
          desc = "Stage Hunk",
        },
        {
          "<leader>gu",
          "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
          desc = "Undo Stage Hunk",
        },
      })
    end,
  },
}
