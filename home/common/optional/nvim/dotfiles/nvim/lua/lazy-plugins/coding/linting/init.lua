return {
	{
		"mfussenegger/nvim-lint",
		enabled = false,
		config = function()
			require("lint").linters_by_ft = {
				lua = { "luacheck" },
				python = { "pylint" },
			}
		end,
	},
	require("lazy-plugins.coding.linting.todo-comments"),
}
