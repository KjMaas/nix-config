return {
  {
    "Exafunction/codeium.vim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    commit = "289eb724e5d6fab2263e94a1ad6e54afebefafb2",
    event = "BufEnter",

    config = function(_, opts)
      vim.g.codeium_enabled = 0
      vim.g.codeium_manual = 1
      vim.g.codeium_disable_bindings = 1

      vim.keymap.set(
        "i",
        "<C-A-l>",
        function() return vim.fn["codeium#Accept"]() end,
        { expr = true }
      )

      require("which-key").add({
        {
          mode = { "i" },
          {
            "<C-A-a>",
            "<cmd>CodeiumAuto<CR>",
            desc = "Auto Trigger",
          },
          {
            "<C-A-c>",
            "<cmd>call codeium#Clear()<CR>",
            desc = "Clear",
          },
          {
            "<C-A-d>",
            "<cmd>CodeiumDisable<CR>",
            desc = "Disable Codeium",
          },
          {
            "<C-A-e>",
            "<cmd>CodeiumEnable<CR>",
            desc = "Enable Codeium",
          },
          -- {
          --   "<C-A-l>",
          --   "<cmd>call codeium#Accept()<CR>",
          --   desc = "Complete",
          -- },
          {
            "<C-A-h>",
            "<cmd>call codeium#Complete()<CR>",
            desc = "Complete",
          },
          {
            "<C-A-j>",
            "<cmd>call codeium#CycleCompletions(1)<CR>",
            desc = "Cycle down",
          },
          {
            "<C-A-k>",
            "<cmd>call codeium#CycleCompletions(-1)<CR>",
            desc = "Cycle up",
          },
          {
            "<C-A-m>",
            "<cmd>CodeiumManual<CR>",
            desc = "Manual Trigger",
          },
        },
      })
    end,
  },
}
