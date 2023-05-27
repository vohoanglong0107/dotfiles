return {
	"rcarriga/nvim-notify",
	lazy = true,
	config = function()
		local notify = require("notify")
		notify.setup({
			background_colour = "#000000",
		})
	end,
}
