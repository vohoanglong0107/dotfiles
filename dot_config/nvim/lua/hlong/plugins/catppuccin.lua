return {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000, -- colorscheme must be loaded first, or else some plugins like bufferline will use incorrect colors
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			integrations = {
				cmp = true,
				dashboard = true,
				flash = true,
				gitsigns = true,
				illuminate = {
					enabled = true,
					lsp = false,
				},
				indent_blankline = { enabled = true },
				lsp_trouble = false,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = { background = true },
				},
				neotest = true,
				notify = true,
				rainbow_delimiters = true,
				telescope = { enabled = true },
				treesitter = true,
				which_key = true,
			},
			highlight_overrides = {
				all = function(colors)
					return {
						LspInfoBorder = { fg = colors.text },
					}
				end,
			},
		})
	end,
}
