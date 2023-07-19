return {
	"folke/todo-comments.nvim",
	cmd = { "TodoTrouble", "TodoTelescope" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("todo-comments").setup({})
	end,
}
