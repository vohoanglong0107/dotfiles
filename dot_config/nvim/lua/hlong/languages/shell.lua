local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

lspconfig.bashls.setup({
	capabilities = base.capabilities,
})

null_ls.register(null_ls.builtins.formatting.shfmt)
