local status_ok, formatter = pcall(require, "formatter")
if not status_ok then
	notify_on_pcall_fail(formatter)
	return
end


local function use_prettierd()
  return {
    exe = "prettierd",
    args = { vim.api.nvim_buf_get_name(0) },
    stdin = true,
  }
end

-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
formatter.setup({
	logging = true,
	log_level = vim.log.levels.WARN,

	-- All formatter configurations are opt-in
	filetype = {
		css = { use_prettierd },
		html = { use_prettierd },
		typescript = { use_prettierd },
		typescriptreact = { use_prettierd },
		javascript = { use_prettierd },
		javascriptreact = { use_prettierd },

		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,

			-- You can also define your own configuration
			function()
				-- Supports conditional formatting
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end

				-- Full specification of configurations is down below and in Vim help
				-- files
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
