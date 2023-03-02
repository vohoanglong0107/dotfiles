local catppuccin_status_ok, catppuccin = pcall(require, "catppuccin")
if not catppuccin_status_ok then
	vim.notify(catppuccin, vim.log.levels.WARN)
	return
end

catppuccin.setup({
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
			}
		end,
	},
})
