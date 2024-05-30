local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = "Disable",
      },
    },
  },
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
  end,
  capabilities = base.capabilities,
})

null_ls.register(null_ls.builtins.formatting.stylua)
