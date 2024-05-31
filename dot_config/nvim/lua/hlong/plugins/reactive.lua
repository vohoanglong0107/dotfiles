return {
	"rasulomaroff/reactive.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("reactive").setup({
			load = { "catppuccin-mocha-cursor", "catppuccin-mocha-cursorline" },
		})
	end,
}
