return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
	config = function()
		local indent_blankline = require("ibl")

		indent_blankline.setup()
	end,
}
