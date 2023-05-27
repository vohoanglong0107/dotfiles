return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = true,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			integrations = {
				leap = true,
				notify = true,
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
				},
			},
			highlight_overrides = {
				all = function(colors)
					return {
						LspInfoBorder = { fg = colors.text },
						IndentBlanklineSpaceCharBlankline = { fg = colors.text },
						IndentBlanklineSpaceChar = { fg = colors.text },
						DashboardProjectTitle = { fg = colors.sapphire },
						DashboardProjectTitleIcon = { fg = colors.sapphire },
						DashboardProjectIcon = { fg = colors.sapphire },
						DashboardMruTitle = { fg = colors.peach },
						DashboardMruIcon = { fg = colors.peach },
						DashboardFiles = { fg = colors.text },
						DashboardShotCutIcon = { fg = colors.peach },
					}
				end,
			},
		})
	end,
}
