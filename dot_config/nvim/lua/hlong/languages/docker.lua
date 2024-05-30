local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

vim.filetype.add({ filename = {
	["devcontainer.json"] = "jsonc",
} })

lspconfig.dockerls.setup({
	capabilities = base.capabilities,
})

null_ls.register(null_ls.builtins.diagnostics.hadolint)
