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
		local utils = require("null-ls.utils").make_conditional_utils()
		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting

		local sources = {
			diagnostics.golangci_lint,
			diagnostics.hadolint,
			formatting.black.with({
				extra_args = { "--fast" },
			}),
			formatting.shfmt,
			formatting.stylua,
		}

		if utils.root_has_file("node_modules/.bin/eslint") then
			table.insert(
				sources,
				formatting.eslint.with({
					command = "node_modules/.bin/eslint",
				})
			)
			table.insert(
				sources,
				diagnostics.eslint.with({
					command = "node_modules/.bin/eslint",
				})
			)
		end

		if utils.root_has_file("node_modules/.bin/prettier") then
			table.insert(
				sources,
				formatting.prettier.with({
					command = "node_modules/.bin/prettier",
					extra_filetypes = { "toml" },
				})
			)
		end

		null_ls.setup({
			border = "rounded",
			debounce = 1000,
			debug = false,
			sources = sources,
		})
	end,
}
