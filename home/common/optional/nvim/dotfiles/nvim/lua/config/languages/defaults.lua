local M = {}

M.servers = {
  -- Lua
  "lua_ls",

  -- Frontend web dev
  "cssls",
  "eslint",
  "html",
  "jsonls",
  -- "tailwindcss", -- INFO: lsp server uses way to much CPU ressources
  "tsserver",
  "volar",

  -- CLI
  "bashls",

  -- Nix
  "nixd",

  -- Python
  "pyright",
  "ruff_lsp",
}

return M
