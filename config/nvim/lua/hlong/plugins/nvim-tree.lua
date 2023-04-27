return {
	"nvim-tree/nvim-tree.lua",
	cmd = "NvimTreeToggle",
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<CR>" },
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
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
			notify = {
				threshold = vim.log.levels.WARN,
			},
		})

		local api = require("nvim-tree.api")
		api.events.subscribe(api.events.Event.FileCreated, function(file)
			vim.cmd("edit " .. file.fname)
		end)
	end,
}
