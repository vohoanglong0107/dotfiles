return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		columns = {
			"icon",
			"permissions",
			"size",
		},
		lsp_file_methods = {
			autosave_changes = "unmodified",
		},
		skip_confirm_for_simple_edits = true,
		watch_for_changes = true,
		keymaps = {
			["<C-c>"] = false,
			["`"] = false,
			["~"] = false,
			["gs"] = false,
			["gx"] = false,
			["g."] = false,
			["g\\"] = false,
			["<leader>e"] = "actions.close",
			["<leader>s"] = "actions.change_sort",
			["<leader>x"] = "actions.open_external",
			["<leader>."] = "actions.toggle_hidden",
			["<C-y>"] = "actions.yank_entry",
		},
	},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
