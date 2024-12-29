return {
	{ "folke/lazy.nvim" },
	{ "github/copilot.vim" },
	{ "nvim-pack/nvim-spectre", lazy = true, opts = {} },
	{ "moll/vim-bbye", cmd = "Bdelete" },
	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
		dependencies = { "mfussenegger/nvim-dap" },
	},
	-- Language specific
	{ "towolf/vim-helm" },
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
}
