-- add the following patch to ~/.local/share/nvim/lazy/oklch-color-picker.nvim/lua/oklch-color-picker/picker.lua:111
-- This unsets the WAYLAND_DISPLAY env var while lounching the oklch clor picker.
-- for more info: https://github.com/eero-lehtinen/oklch-color-picker.nvim/issues/3#issuecomment-2555577076

-- local env = vim.fn.environ()
-- env.WAYLAND_DISPLAY = ""
-- vim.system(cmd, {
--   stdout = stdout,
--   stderr = stderr,
--   env = env,
-- }, function(res)

return {
  "eero-lehtinen/oklch-color-picker.nvim",
  event = "VeryLazy",
  version = "*",
  keys = {
    -- One handed keymap recommended, you will be using the mouse
    {
      "<leader>v",
      function() require("oklch-color-picker").pick_under_cursor({ fallback_open = {} }) end,
      desc = "Color pick under cursor",
    },
  },
  ---@type oklch.Opts
  opts = {},
}
