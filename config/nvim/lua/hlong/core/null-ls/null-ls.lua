local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	vim.notify(null_ls, vim.log.levels.WARN)
	return
end

local utils = require("null-ls.utils").make_conditional_utils()
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

local sources = {
	code_actions.eslint,
	code_actions.gitrebase,
	code_actions.gitsigns,
	diagnostics.flake8,
	diagnostics.golangci_lint,
	diagnostics.hadolint,
	diagnostics.shellcheck,
	formatting.isort,
	formatting.black.with({
		extra_args = { "--fast" },
	}),
	formatting.prettier.with({
		command = utils.root_has_file("node_modules/.bin/prettier") and "node_modules/.bin/prettier" or "prettier",
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
