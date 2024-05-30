-- HCL is the language used in Terraform configuration files

local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")

vim.treesitter.language.register("terraform", "terraform-vars")

lspconfig.terraformls.setup({
  capabilities = base.capabilities,
})

lspconfig.tflint.setup({
  capabilities = base.capabilities,
})
