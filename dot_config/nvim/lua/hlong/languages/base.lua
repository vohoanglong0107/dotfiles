local cmp_nvim_lsp = require("cmp_nvim_lsp")

local keymaps = require("hlong.keymaps")

local M = {}

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
default_capabilities.textDocument.completion.completionItem.snippetSupport = true
default_capabilities = cmp_nvim_lsp.default_capabilities(default_capabilities)

local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		keymaps.set(keymaps.lsp(bufnr))

		-- Enable auto-format on save
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false, timeout = 2000 })
				end,
				group = lsp_group,
			})
		end

		if client.supports_method("textDocument/codeLens") then
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
				buffer = bufnr,
				callback = function()
					vim.lsp.codelens.refresh({ bufnr = bufnr })
				end,
				group = lsp_group,
			})
		end

		local inlay_hint_enable = false
		if client.server_capabilities.inlayHintProvider then
			inlay_hint_enable = true
		end

		vim.lsp.inlay_hint.enable(inlay_hint_enable)
	end,
})

M.capabilities = default_capabilities

return M
