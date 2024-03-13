return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "akinsho/toggleterm.nvim",
    },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      -- { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gO", "<cmd>LazyGitConfig<cr>", desc = "LazyGit configuration" },
      { "<leader>gc", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit current file" },
      { "<leader>gF", "<cmd>LazyGitFilter<cr>", desc = "LazyGit filter" },
      { "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit filter current file" },
      {
        "<leader>fg",
        "<cmd>lua require('telescope').extensions.lazygit.lazygit()<cr>",
        desc = "LazyGit with Telescope",
      },
    },
    config = function() require("telescope").load_extension("lazygit") end,

    init = function()
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        name = "lazygit",
        cmd = "lazygit",
        count = 5,
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "curved",
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(
            term.bufnr,
            "n",
            "q",
            "<cmd>close<CR>",
            { noremap = true, silent = true }
          )
        end,
        -- function to run on closing the terminal
        on_close = function(term) vim.cmd("startinsert!") end,
      })

      function _lazygit_toggle() lazygit:toggle() end

      vim.api.nvim_set_keymap(
        "n",
        "<leader>gg",
        "<cmd>lua _lazygit_toggle()<CR>",
        { noremap = true, silent = true, desc = "LazyGit with ToggleTerm" }
      )
    end,
  },
}
