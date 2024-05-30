local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")

lspconfig.jdtls.setup({
	capabilities = base.capabilities,
})
