local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	vim.notify(null_ls, vim.log.levels.WARN)
	return
end

local key = 1

local providers = require("hlong.core.null-ls.providers")
local sources = {}
for _, provider in pairs(providers) do
	local require_ok, opts = pcall(require, "hlong.core.null-ls.providers." .. provider)
	if require_ok then
		sources[key] = opts
		key = key + 1
	end
end

local null_ls_group = vim.api.nvim_create_augroup("null-ls", { clear = true })

null_ls.setup({
	border = "rounded",
	debug = false,
	sources = sources,
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "<buffer>",
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
				group = null_ls_group,
			})
		end
	end,
})
