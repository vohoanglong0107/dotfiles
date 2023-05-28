return {
	"jose-elias-alvarez/null-ls.nvim",
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
				"shellcheck",
				"shfmt",
			},
			automatic_installation = true,
		})

		local null_ls = require("null-ls")
		local utils = require("null-ls.utils").make_conditional_utils()
		local code_actions = null_ls.builtins.code_actions
		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting

		local sources = {
			code_actions.eslint,
			diagnostics.flake8,
			diagnostics.golangci_lint,
			diagnostics.hadolint,
			diagnostics.shellcheck,
			formatting.isort,
			formatting.black.with({
				extra_args = { "--fast" },
			}),
			formatting.prettier.with({
				command = utils.root_has_file("node_modules/.bin/prettier") and "node_modules/.bin/prettier"
					or "prettier",
				extra_filetypes = { "toml" },
			}),
			formatting.shfmt,
			formatting.stylua,
		}

		null_ls.setup({
			border = "rounded",
			debounce = 1000,
			debug = false,
			sources = sources,
		})
	end,
}
