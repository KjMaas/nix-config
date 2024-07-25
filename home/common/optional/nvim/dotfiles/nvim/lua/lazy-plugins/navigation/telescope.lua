return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      { "nvim-tree/nvim-web-devicons", opt = true },
    },

    config = function(_, opts)
      -- Configure how Telescope works
      local status_ok, telescope = pcall(require, "telescope")
      if not status_ok then return end

      local actions = require("telescope.actions")

      -- Load extensions
      -- telescope.load_extension('dap')
      -- telescope.load_extension('projects')
      telescope.load_extension("notify")

      telescope.setup({
        defaults = {

          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "smart" },

          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,

              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,

              ["<C-c>"] = actions.close,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,

              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<C-h>"] = actions.which_key,
            },

            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["<C-h>"] = actions.which_key,
            },
          },
        },

        pickers = {
          theme = "cursor",
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },

        extensions = {
          media_files = {
            filetypes = { "png", "jpg", "mp4", "webm", "pdf" }, -- filetypes whitelist
            find_cmd = "rg",
          },
        },
      })

      -- Register mappings with which-key
      local status_ok, which_key = pcall(require, "which-key")
      if not status_ok then
        print("there's an issue with which-key")
        return
      end

      require("which-key").add({
        { "<leader>f", group = "Find", nowait = true, remap = false },
        {
          "<leader>fb",
          "<cmd>Telescope buffers<cr>",
          desc = "Buffers",
        },
        {
          "<leader>fc",
          "<cmd>Telescope commands<cr>",
          desc = "Commands",
        },
        {
          "<leader>ff",
          "<cmd>Telescope find_files<cr>",
          desc = "Files",
        },
        {
          "<leader>fh",
          "<cmd>Telescope help_tags<cr>",
          desc = "Help",
        },
        {
          "<leader>fk",
          "<cmd>Telescope keymaps<cr>",
          desc = "Keymaps",
        },
        {
          "<leader>fn",
          "<cmd>Telescope notify<cr>",
          desc = "Notifications",
        },
        {
          "<leader>fp",
          "<cmd>Telescope projects<cr>",
          desc = "Projects",
        },
        {
          "<leader>fr",
          "<cmd>Telescope oldfiles<cr>",
          desc = "Recent Files",
        },
        {
          "<leader>fs",
          "<cmd>Telescope live_grep<cr>",
          desc = "Text",
        },
      })
    end,
  },
}
