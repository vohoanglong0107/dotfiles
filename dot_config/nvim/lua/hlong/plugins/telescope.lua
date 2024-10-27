return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- note, if a build failed, lazy will not auto rebuild it
		-- https://github.com/nvim-telescope/telescope-fzf-native.nvim/issues/96#issuecomment-1415302302
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-symbols.nvim",
		"rcarriga/nvim-notify",
	},
	cmd = "Telescope",
	lazy = true,
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		local action_mt = require("telescope.actions.mt")
		local trouble = require("trouble.sources.telescope")

		local M = {}
		M.yank_selection = function(prompt_bufnr)
			local entry = action_state.get_selected_entry()
			vim.fn.setreg("+", entry.value)
			vim.fn.setreg("", entry.value)
		end

		M = action_mt.transform_mod(M)

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-q>"] = trouble.open,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = {
						["<C-q>"] = trouble.open,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["y"] = M.yank_selection,
					},
				},
				file_ignore_patterns = { "%.git/" },
				path_display = { "truncate" },
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
			-- https://github.com/nvim-telescope/telescope.nvim/issues/855#issuecomment-1032325327
			pickers = {
				live_grep = {
					additional_args = function(opts)
						return {
							"--hidden",
						}
					end,
					glob_pattern = {
						"!gazelle_python.yaml",
						"!pnpm-lock.yaml",
						"!**/requirements_lock.txt",
						"!.git",
					},
				},
				find_files = {
					hidden = true,
				},
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("notify")
	end,
}
