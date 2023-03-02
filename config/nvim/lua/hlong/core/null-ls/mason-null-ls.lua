local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not status_ok then
	vim.notify(mason_null_ls, vim.log.levels.WARN)
	return
end

mason_null_ls.setup({
	ensure_installed = {
		"golangci_lint",
		"hadolint",
		"prettier",
		"shellcheck",
		"shfmt",
		"stylua",
	},
	automatic_installation = true,
})
