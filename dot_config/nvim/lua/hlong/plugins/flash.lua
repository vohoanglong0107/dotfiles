return {
	"folke/flash.nvim",
	lazy = true,
	config = function()
		require("flash").setup({
			modes = {
				search = {
					enabled = false,
				},
			},
		})
	end,
}
