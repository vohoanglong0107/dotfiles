local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
	vim.notify(vim.inspect(telescope), vim.log.levels.WARN)
	return
end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_mt = require("telescope.actions.mt")
local trouble = require("trouble.providers.telescope")

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
				["<C-q>"] = trouble.open_with_trouble,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
			n = {
				["<C-q>"] = trouble.open_with_trouble,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["y"] = M.yank_selection,
			},
		},
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
					"--glob",
					"!gazelle_python.yaml",
					"--glob",
					"!pnpm-lock.yaml",
					"--glob",
					"!**/requirements_lock.txt",
				}
			end,
		},
	},
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("fzf")
telescope.load_extension("notify")
