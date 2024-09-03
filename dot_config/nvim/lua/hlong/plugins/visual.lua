--- Visual only plugins live here
return {
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
				messages = {
					enabled = false,
				},
				views = {
					mini = {
						win_options = {
							winblend = 0,
						},
					},
				},
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("todo-comments").setup({})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		config = function()
			local indent_blankline = require("ibl")

			indent_blankline.setup({
				indent = {
					tab_char = "▎",
				},
			})
		end,
	},
	{
		"rasulomaroff/reactive.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("reactive").setup({
				load = { "catppuccin-mocha-cursor", "catppuccin-mocha-cursorline" },
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		lazy = true,
		config = function()
			local notify = require("notify")
			notify.setup({
				background_colour = "#000000",
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					win_options = {
						-- https://github.com/catppuccin/nvim/issues/401
						winblend = 0,
					},
				},
			})
		end,
	},
	{ "RRethy/vim-illuminate" },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
}
