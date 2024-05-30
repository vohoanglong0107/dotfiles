-- HCL is the language used in Terraform configuration files

local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")

vim.treesitter.language.register("terraform", "terraform-vars")

lspconfig.terraformls.setup({
	on_attach = function(client, bufnr)
		base.setup_default_keymaps(bufnr)
		base.setup_auto_format_on_save(client)
	end,
	capabilities = base.capabilities,
})

lspconfig.tflint.setup({
	on_attach = function(client, bufnr)
		base.setup_default_keymaps(bufnr)
		base.setup_auto_format_on_save(client)
	end,
	capabilities = base.capabilities,
})
