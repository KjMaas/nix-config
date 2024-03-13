return {
	{

		"Exafunction/codeium.vim",

		config = function(_, opts)
			vim.g.codeium_enabled = 0
			vim.g.codeium_manual = 1
			vim.g.codeium_disable_bindings = 1

			vim.keymap.set("i", "<C-A-l>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })

			-- Register mappings with which-key
			local status_ok, which_key = pcall(require, "which-key")
			if not status_ok then
				print("there's an issue with which-key")
				return
			end

			local mappings = {

				["<C-A-a>"] = { "<cmd>CodeiumAuto<CR>", "Auto Trigger" },
				["<C-A-m>"] = { "<cmd>CodeiumManual<CR>", "Manual Trigger" },
				["<C-A-d>"] = { "<cmd>CodeiumDisable<CR>", "Disable Codeium" },
				["<C-A-e>"] = { "<cmd>CodeiumEnable<CR>", "Enable Codeium" },
				["<C-A-c>"] = { "<cmd>call codeium#Clear()<CR>", "Clear" },
				["<C-A-h>"] = { "<cmd>call codeium#Complete()<CR>", "Complete" },
				-- ["<C-A-l>"] = { "<cmd>call codeium#Accept()<CR>", "Accept" },
				["<C-A-j>"] = { "<cmd>call codeium#CycleCompletions(1)<CR>", "Cycle down" },
				["<C-A-k>"] = { "<cmd>call codeium#CycleCompletions(-1)<CR>", "Cycle up" },
			}

			local opts = {
				mode = "i",
				prefix = "",
				buffer = nil,
				silent = false,
				noremap = true,
				nowait = false,
			}

			which_key.register(mappings, opts)
		end,
	},
}
