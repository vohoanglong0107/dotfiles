local neodev_status_ok, neodev = pcall(require, "neodev")
if not neodev_status_ok then
	vim.notify(neodev, vim.log.levels.WARN)
	return
end

neodev.setup()

return {
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
				library = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
			},
		},
	},
}
