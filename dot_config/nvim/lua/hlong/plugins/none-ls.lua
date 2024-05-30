return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"jayp0521/mason-null-ls.nvim",
		"williamboman/mason.nvim",
	},
	config = function()
		require("mason-null-ls").setup({
			ensure_installed = {
				"golangci_lint",
				"prettier",
				"shfmt",
			},
			automatic_installation = true,
		})

		local null_ls = require("null-ls")

		null_ls.setup({
			border = "rounded",
			debounce = 1000,
			debug = false,
		})
	end,
}
