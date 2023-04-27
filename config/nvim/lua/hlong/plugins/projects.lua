return {
	"ahmedkhalf/project.nvim",
	lazy = true,
	config = function()
		require("project_nvim").setup({
			-- manual_mode = true,
			-- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
			detection_methods = { "pattern" },
			-- patterns used to detect root dir, when **"pattern"** is in detection_methods
			patterns = { ".git", "WORKSPACE", "WORKSPACE.bazel" },
			silent_chdir = true,
		})
	end,
}
