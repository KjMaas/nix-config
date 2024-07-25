return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", opt = true },
    { "echasnovski/mini.nvim", version = false },
  },
  opts = {},
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    {
      "<leader>e",
      "<cmd>NvimTreeToggle<cr>",
      desc = "Explorer",
    },
    {
      "<leader>h",
      "<cmd>nohlsearch<CR>",
      desc = "No Highlight",
    },
    { "<leader>q", "<cmd>q!<CR>", desc = "Quit!", nowait = false, remap = false },
  },
}
