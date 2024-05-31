return {
	"folke/flash.nvim",
	lazy = false,
	config = function()
		require("flash").setup({
			modes = {
				search = {
					enabled = true,
				},
			},
		})
	end,
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
	},
}
