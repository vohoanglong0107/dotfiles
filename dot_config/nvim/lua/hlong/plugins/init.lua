return {
	{ "folke/lazy.nvim" },
	{ "github/copilot.vim" },
	{ "nvim-pack/nvim-spectre", lazy = true, opts = {} },
	{ "moll/vim-bbye", cmd = "Bdelete" },
	-- Language specific
	{ "towolf/vim-helm" },
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	-- UI
	{ "folke/trouble.nvim", cmd = { "Trouble" }, opts = {} },
	{ "RRethy/vim-illuminate" },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
}
