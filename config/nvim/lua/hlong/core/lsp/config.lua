local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	vim.notify(lspconfig, vim.log.levels.WARN)
	return
end

local providers = require("hlong.core.lsp.providers")

local opts = {}

for _, server in pairs(providers.servers) do
	opts = {
		on_attach = require("hlong.core.lsp.handlers").on_attach,
		capabilities = require("hlong.core.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "hlong.core.lsp.providers." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
require("lspconfig.ui.windows").default_options.border = "rounded"
