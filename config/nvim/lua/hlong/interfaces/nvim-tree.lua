vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvim_tree = require("nvim-tree")
nvim_tree.setup({
	remove_keymaps = { "<C-e>", "s", "S" },
	update_focused_file = {
		enable = true,
	},
	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
	git = {
		enable = true,
		ignore = false,
	},
	hijack_directories = {
		enable = false,
	},
})

local api = require("nvim-tree.api")
api.events.subscribe(api.events.Event.FileCreated, function(file)
	vim.cmd("edit " .. file.fname)
end)
