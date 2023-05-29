return {
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
}
