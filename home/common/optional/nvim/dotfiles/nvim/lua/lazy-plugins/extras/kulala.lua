return {
  -- HTTP REST-Client Interface
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  opts = {
    debug = false,
    display_mode = "float",
    q_to_close_float = true,
    kulala_keymaps = true,
    global_keymaps = true,
  },
  keys = {
    { "<CR>", function() require("kulala").run() end, desc = "Run Kulala request" },
    { "<leader>ks", function() require("kulala").scratchpad() end, desc = "Open scratchpad" },
    { "<leader>ka", function() require("kulala").run_all() end, desc = "Run Kulala all requests" },
    { "<leader>ko", function() require("kulala").open() end, desc = "Open kulala" },
    {
      "<leader>kt",
      function() require("kulala").toggle_view() end,
      desc = "Toggle headers/body",
    },
    {
      "<leader>kS",
      function() require("kulala").show_stats() end,
      desc = "Show stats",
    },
    {
      "<leader>kc",
      function() require("kulala").copy() end,
      desc = "Copy as cURL",
    },
    {
      "<leader>kC",
      function() require("kulala").from_curl() end,
      desc = "Paste from curl",
    },
    {
      "<leader>ki",
      function() require("kulala").inspect() end,
      desc = "Inspect current request",
    },
    {
      "<leader>kr",
      function() require("kulala").replay() end,
      desc = "Replay the last request",
    },
    {
      "<leader>kf",
      function() require("kulala").search() end,
      desc = "Find request",
    },
    {
      "<leader>kj",
      function() require("kulala").jump_next() end,
      desc = "Jump to next request",
    },
    {
      "<leader>kk",
      function() require("kulala").jump_prev() end,
      desc = "Jump to previous request",
    },
    {
      "<leader>ke",
      function() require("kulala").set_selected_env() end,
      desc = "Select environment",
    },
    {
      "<leader>kg",
      function() require("kulala").download_graphql_schema() end,
      desc = "Download GraphQL schema",
    },
    {
      "<leader>kx",
      function() require("kulala").scripts_clear_global() end,
      desc = "Clear globals",
    },
    {
      "<leader>kX",
      function() require("kulala").clear_cached_files() end,
      desc = "Clear cached files",
    },
  },
}
