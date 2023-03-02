local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	vim.notify(mason_lspconfig, vim.log.levels.WARN)
	return
end
local providers = require("hlong.core.lsp.providers")

mason_lspconfig.setup({
	ensure_installed = providers.servers,
	automatic_installation = true,
})
