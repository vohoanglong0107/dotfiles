local toggleterm_status_ok, toggleterm = pcall(require, "toggleterm")
if not toggleterm_status_ok then
	vim.notify(toggleterm, vim.log.levels.WARN)
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
	},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	-- vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	-- vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	-- vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	-- vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)

	-- for using oh-my-zsh vim binding, without this <c-[> will be translated
	-- to <esc> and back to buffer normal mode, not normal mode in terminal
	vim.api.nvim_buf_set_keymap(0, "t", "<c-[>", "<c-[>", opts)
end

local toggleterm_group = vim.api.nvim_create_augroup("ToggleTerm", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		set_terminal_keymaps()
	end,
	group = toggleterm_group,
})
