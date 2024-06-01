return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		-- Unless you are still migrating, remove the deprecated commands from v1.x
		vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
		require("neo-tree").setup({
			-- A list of functions, each representing a global custom command
			-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
			-- see `:h neo-tree-global-custom-commands`

			window = {
				position = "left",
				width = 40,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["S"] = "noop",
					["s"] = "noop",
					["o"] = "open",
					["/"] = "noop", -- default search feature in neotree is so hard to use. Better to use telescope for this
					["?"] = "noop",
					["g?"] = "show_help",
					["<bs>"] = "noop", -- therer is no need to navigate up the tree
					-- move to parent
					["P"] = function(state)
						local node = state.tree:get_node()
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end,
					-- copy path -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/597#issuecomment-1312826244
					["<c-y>"] = function(state)
						local node = state.tree:get_node()
						local content = node.path:gsub(state.path, ""):sub(2)
						vim.fn.setreg('"', content)
						vim.fn.setreg("1", content)
						vim.fn.setreg("+", content)
					end,
				},
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
				},
				follow_current_file = {
					enabled = true,
				},
				use_libuv_file_watcher = true,
				window = {
					fuzzy_finder_mappings = {
						["<C-j>"] = "move_cursor_down",
						["<C-k>"] = "move_cursor_up",
					},
				},
			},
		})
	end,
}
