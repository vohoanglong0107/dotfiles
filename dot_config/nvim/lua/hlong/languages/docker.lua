local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

vim.filetype.add({ filename = {
	["devcontainer.json"] = "jsonc",
} })

lspconfig.dockerls.setup({
	on_attach = function(_, bufnr)
		base.setup_default_keymaps(bufnr)
	end,
	capabilities = base.capabilities,
})

null_ls.register(null_ls.builtins.diagnostics.hadolint)
