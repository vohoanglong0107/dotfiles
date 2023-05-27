return {
	"kylechui/nvim-surround",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects" },
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-surround").setup({})
	end,
}
