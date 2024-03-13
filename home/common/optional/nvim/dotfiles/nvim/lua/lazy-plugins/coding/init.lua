return {
	-- git
	"tpope/vim-fugitive",

	-- text edition
	"tpope/vim-surround",
	"tpope/vim-speeddating",
	"tpope/vim-repeat",
	"junegunn/vim-easy-align",

	require("lazy-plugins.coding.ai"),
	require("lazy-plugins.coding.formatting"),
	require("lazy-plugins.coding.linting"),
	require("lazy-plugins.coding.lsp"),
}
