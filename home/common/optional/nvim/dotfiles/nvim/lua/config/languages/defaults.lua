local M = {}

M.servers = {
  -- Lua
  "lua_ls",

  -- Frontend web dev
  "cssls",
  "eslint",
  "html",
  "jsonls",
  "tailwindcss",
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
