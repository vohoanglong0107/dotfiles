local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not status_ok then
	vim.notify(mason_null_ls, vim.log.levels.WARN)
	return
end

local providers = require("hlong.core.lsp.providers")
mason_null_ls.setup({
	ensure_installed = providers.servers,
	automatic_installation = true,
})
