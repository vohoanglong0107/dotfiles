return {
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
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			-- routes = {
			-- 	{
			-- 		filter = {
			-- 			event = "msg_show",
			-- 			kind = "",
			-- 			find = "written",
			-- 		},
			-- 		view = "mini",
			-- 	},
			--   {
			--       view = "notify",
			--       filter = { event = "msg_showmode" },
			--     },
			-- },
			messages = {
				view = "left_mini",
			},
			views = {
				mini = {
					win_options = {
						winblend = 0,
					},
				},
				left_mini = {
					backend = "mini",
					relative = "editor",
					timeout = 2000,
					reverse = true,
					focusable = false,
					position = {
						row = -1,
						-- col = "100%",
						col = 0,
					},
					size = {
						width = "auto",
						height = "auto",
						max_height = 1,
					},
					border = {
						style = "none",
					},
					zindex = 60,
					win_options = {
						winblend = 0,
						winhighlight = {
							Normal = "NoiceMini",
							IncSearch = "",
							Search = "",
						},
					},
				},
			},
		})
	end,
}
