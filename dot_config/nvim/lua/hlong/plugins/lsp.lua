local ensure_installed = {
  "bashls",
  "cssls",
  "dockerls",
  "jsonls",
  "pyright",
  "lua_ls",
  "tsserver",
  "yamlls",
}

return {
  "neovim/nvim-lspconfig",
  lazy = false, -- too many plugins depend on this, lazy loading it will cause issues
  dependencies = {
    "b0o/schemastore.nvim",
    "folke/neoconf.nvim",
    "folke/neodev.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
  },
  config = function()
    require("neoconf").setup()
    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
    })
    require("neodev").setup({
      override = function(root_dir, library)
        if string.find(root_dir, "nvim") ~= nil then
          library.enabled = true
          library.plugins = true
        end
      end,
    })

    require("lspconfig.ui.windows").default_options.border = "rounded"
  end,
}
