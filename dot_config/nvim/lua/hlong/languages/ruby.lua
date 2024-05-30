
local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")

lspconfig.ruby_lsp.setup({
	capabilities = base.capabilities,
})
