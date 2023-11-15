-- NVIM tree
-- all options are well documented in `:help nvim-tree.OPTION_NAME`


local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  notify_on_pcall_fail(nvim_tree)
  return
end


local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '?',     api.tree.toggle_help,           opts('Help'))
  vim.keymap.set('n', '<C-u>', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'L',     api.tree.change_root_to_node,   opts('CD'))
  vim.keymap.set('n', 'l',     api.node.open.edit,             opts('Open'))
  vim.keymap.set('n', 'h',     api.node.navigate.parent_close, opts('Close Directory'))

end

nvim_tree.setup {
  on_attach = my_on_attach,

  disable_netrw = true,
  hijack_netrw = true,
  auto_reload_on_write = true,
  root_dirs = {"git"},

  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },

  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },

  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
    update_cwd = true,
    ignore_list = {},
  },

  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },

  actions = {
    open_file = {
      resize_window = true,
      quit_on_open = false,
    },
  },

  view = {
    adaptive_size = false,
    width = 30,
    side = "left",
    number = false,
    relativenumber = false,
  },

  renderer = {
    root_folder_modifier = ":t",
    highlight_git = true,
    icons = {
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      }
    }
  },

  -- -- Enable/Disable logs in ($XDG_CACHE_HOME|$HOME/.config)nvim/nvim-tree.log
  -- log = {
  --   enable = false,
  --   truncate = true,
  --   types = {
  --     git = true,
  --     profile = true,
  --   },
  -- },

}
