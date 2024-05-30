local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils").make_conditional_utils()

lspconfig.biome.setup({
  capabilities = base.capabilities,
})

lspconfig.cssls.setup({
  capabilities = base.capabilities,
})

lspconfig.jsonls.setup({
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
  end,
  capabilities = base.capabilities,
})

lspconfig.tsserver.setup({
  init_options = {
    preferences = { includeCompletionsForModuleExports = false },
  },
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
  end,
  capabilities = base.capabilities,
})

if null_ls_utils.root_has_file("node_modules/.bin/eslint") then
  null_ls.register({
    null_ls.builtins.formatting.eslint.with({
      command = "node_modules/.bin/eslint",
    }),
    null_ls.builtins.diagnostics.eslint.with({
      command = "node_modules/.bin/eslint",
    }),
  })
end

if null_ls_utils.root_has_file("node_modules/.bin/prettier") then
  null_ls.register({
    null_ls.builtins.formatting.prettier.with({
      command = "node_modules/.bin/prettier",
      extra_filetypes = { "toml" },
    }),
  })
end
