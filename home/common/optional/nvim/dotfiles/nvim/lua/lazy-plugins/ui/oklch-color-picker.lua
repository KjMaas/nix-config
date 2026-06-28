-- Workaround for Wayland bug: https://github.com/eero-lehtinen/oklch-color-picker.nvim/issues/3#issuecomment-2555577076
-- Unsets WAYLAND_DISPLAY before launching the picker so it falls back to X11/XWayland.
local function with_wayland_unset(fn)
  return function(...)
    local saved = vim.env.WAYLAND_DISPLAY
    vim.env.WAYLAND_DISPLAY = ""
    local ok, result = pcall(fn, ...)
    vim.env.WAYLAND_DISPLAY = saved
    if not ok then error(result) end
    return result
  end
end

return {
  "eero-lehtinen/oklch-color-picker.nvim",
  event = "VeryLazy",
  version = "*",
  keys = {
    -- One handed keymap recommended, you will be using the mouse
    {
      "<leader>v",
      function()
        with_wayland_unset(require("oklch-color-picker").pick_under_cursor)({ fallback_open = {} })
      end,
      desc = "Color pick under cursor",
    },
  },
  ---@type oklch.Opts
  opts = {},
}
