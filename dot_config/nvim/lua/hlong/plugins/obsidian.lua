local inside_obsidian_vault = vim.fn.isdirectory(".obsidian")
local workspaces = {}
if inside_obsidian_vault ~= 0 then
	table.insert(workspaces, {
		name = "personal",
		path = vim.fn.getcwd(),
	})
end

return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = not (inside_obsidian_vault ~= 0),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		detect_cwd = false,
		workspaces = workspaces,
		daily_notes = {
			folder = "journals",
      date_format = "%Y-%m-%d",
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = "journal.md",
		},
		completion = {
			nvim_cmp = true,
			min_chars = 1,
			new_notes_location = "current_dir",
			prepend_note_id = false,
			prepend_note_path = true,
			use_path_only = false,
		},
		templates = {
			subdir = "templates",
		},
	},
}
