local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

lspconfig.pyright.setup({
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
  capabilities = base.capabilities,
})

lspconfig.ruff_lsp.setup({
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
  capabilities = base.capabilities,
})

-- TODO: we have ruff_lsp, so we don't need this
null_ls.register(null_ls.builtins.formatting.black.with({
  extra_args = { "--fast" },
}))
