return {
	"epwalsh/obsidian.nvim",
	version = "*",
	cond = function()
		local is_inside_vault = vim.fn.isdirectory(".obsidian")
		return is_inside_vault == 1
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = function()
					return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
				end,
			},
		},
		daily_notes = {
			folder = "journals",
			date_format = "%Y-%m-%d",
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = "journal.md",
		},
		completion = {
			nvim_cmp = true,
			min_chars = 1,
		},
		new_notes_location = "current_dir",
		wiki_link_func = function(opts)
			require("obsidian.util").prepend_note_path(opts)
		end,
		templates = {
			subdir = "templates",
		},
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>oc"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true, desc = "Toggle checkbox in obsidian vault" },
			},
		},
	},
}
