return {
	require("lspconfig").pyright.setup({
		on_attach = require("lazy-plugins.coding.lsp.handlers").on_attach,
		capabilities = require("lazy-plugins.coding.lsp.handlers").capabilities,
		settings = {
			pyright = {
				-- Using Ruff's import organizer
				disableOrganizeImports = true,
			},
		},
	}),

	require("lspconfig").ruff_lsp.setup({
		on_attach = require("lazy-plugins.coding.lsp.handlers").on_attach,
		capabilities = require("lazy-plugins.coding.lsp.handlers").capabilities,
	}),
}
