local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
		},
	},
	on_attach = function(client, bufnr)
		base.setup_default_keymaps(bufnr)
		base.setup_auto_format_on_save(client)
	end,
	capabilities = base.capabilities,
})
