return {
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "",
					package_pending = "󰁇",
					package_uninstalled = "",
				},
			},
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
		})
	end,
}
