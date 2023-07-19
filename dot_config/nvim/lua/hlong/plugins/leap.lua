return {
	"ggandor/leap.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"tpope/vim-repeat",
	},
	config = function()
		require("leap").add_default_mappings()
	end,
}
