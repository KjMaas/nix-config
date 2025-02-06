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
  "ts_ls",
  "volar", -- INFO: volar LSP no longer availlable in nixpkgs 24.11

  -- CLI
  "bashls",

  -- Nix
  "nixd",

  -- Python
  "pyright",
  "ruff",
}

return M
