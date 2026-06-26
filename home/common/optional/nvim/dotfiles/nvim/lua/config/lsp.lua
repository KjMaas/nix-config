-- Configure LSP clients
--
-- Set default root markers for all clients
vim.lsp.config("*", {
  root_markers = { ".git" },
})

-- Enable Language Servers

vim.lsp.enable({
  "vue_ls",
  "vtsls",
  "tailwindcss",
  -- 'eslint',
  -- 'cssls',
  -- 'jsonls',
})
-- vim.lsp.enable("tofu_ls")
-- vim.lsp.enable("luals")
vim.lsp.enable({
  "ruff",
  "pyright",
})

-- Diagnostics setup and toggle
vim.diagnostic.config({
  signs = {
    active = true,
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "󰟃",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  virtual_lines = false,
  virtual_text = false,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    focusable = true,
    style = "minimal",
    source = true,
    header = "",
    prefix = "",
    format = function(diagnostic)
      return string.format(
        "%s (%s) [%s]",
        diagnostic.message,
        diagnostic.source,
        diagnostic.code or diagnostic.user_data.lsp.code
      )
    end,
  },
})

vim.keymap.set("n", "gK", function()
  local new_config = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = new_config, -- Show text after diagnostics
  })
end, { desc = "Toggle diagnostic virtual_text" })

-- Autocmds
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { noremap = true, silent = true, buffer = args.buf }

    vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", opts)
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set({ "n", "x" }, "gq", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)

    vim.keymap.set("n", "grt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
    vim.keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Disable hover in favor of Pyright
    if client.name == "ruff" then client.server_capabilities.hoverProvider = false end

    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})
