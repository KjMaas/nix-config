return {
  -- HTTP REST-Client Interface
  "mistweaverco/kulala.nvim",
  opts = {
    display_mode = "float",
    q_to_close_float = true,
  },

  vim.filetype.add({
    extension = {
      ["http"] = "http",
    },
  }),
}
