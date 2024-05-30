local M = {}
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
default_capabilities.textDocument.completion.completionItem.snippetSupport = true
default_capabilities = cmp_nvim_lsp.default_capabilities(default_capabilities)

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set
  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "<leader>li", vim.lsp.buf.implementation, opts)
  keymap("n", "gr", vim.lsp.buf.references, opts)
  keymap("n", "<leader>ll", vim.diagnostic.open_float, opts)
  keymap("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
  keymap("n", "<leader>lj", vim.diagnostic.goto_next, opts)
  keymap("n", "<leader>lk", vim.diagnostic.goto_prev, opts)
  keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
  keymap("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
  keymap("n", "<leader>lq", "<cmd>Trouble document_diagnostics<CR>", opts)
end

local lspconfig_group = vim.api.nvim_create_augroup("LspConfig", { clear = true })

local function setup_auto_format_on_save(client)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "<buffer>",
      callback = function()
        vim.lsp.buf.format({ async = false, timeout = 2000 })
      end,
      group = lspconfig_group,
    })
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    setup_auto_format_on_save(client)
    lsp_keymaps(bufnr)

    if client.supports_method("textDocument/codeLens") then
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = bufnr })
        end,
      })
    end

    if client.supports_method("textDocument/inlayHints") then
      vim.lsp.inlay_hint.enable(true)
    end
  end,
})

M.default_capabilities = default_capabilities

return M
