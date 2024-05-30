local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")

lspconfig.yamlls.setup({
	settings = {
		yaml = {
			schemastore = { enable = true },
		},
	},
	on_attach = function(_, bufnr)
		if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
			vim.diagnostic.disable(bufnr)
		end
	end,
	capabilities = base.capabilities,
})
