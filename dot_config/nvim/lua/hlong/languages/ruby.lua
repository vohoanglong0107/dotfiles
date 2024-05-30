
local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")

lspconfig.ruby_lsp.setup({
	on_attach = function(_, bufnr)
		base.setup_default_keymaps(bufnr)
	end,
	capabilities = base.capabilities,
})
