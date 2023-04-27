return {
	"folke/which-key.nvim",
	event = { "VeryLazy" },
	config = function()
		require("which-key").setup({
			show_keys = false,
		})

		-- From https://www.reddit.com/r/neovim/comments/vwud6m/comment/ifsflsl/?utm_source=share&utm_medium=web2x&context=3
		-- TLDR: using vim.keymap.set will automatically setup which-key
		-- Quote original
		-- IMO, since 0.7 the best method would be to use vim.keymap.set with { desc = <description> } sent in the call options, which-key can retrieve the description and will show it as if it was configured within which-key, the benefit of it is certain conditional keybinds won’t show up where they aren’t configured.
		--
		-- For example, LSP formatting: say you have a conditional keybind for formatting that only gets defined if the LSP server supports it and you defined it as <leader>f, now open a file and press <leader> your formatting keybind will only show up when relevant.
		--
		-- The above has a few other good use cases, markdown preview binding that only gets defined for markdown files, etc.
		--
		-- EDIT: here’s an example how to define it: vim.keymap.set('n', 'gq', '<cmd>lua vim.lsp.buf.formatting()<CR>', { desc = "format document [LSP]" })
	end,
}
