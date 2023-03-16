local project_status_ok, project = pcall(require, "project_nvim")
if not project_status_ok then
  vim.notify(project, vim.log.levels.WARN)
  return
end
project.setup({
  -- manual_mode = true,
  -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
  detection_methods = { "pattern" },
  -- patterns used to detect root dir, when **"pattern"** is in detection_methods
  patterns = { ".git", "WORKSPACE", "WORKSPACE.bazel" },
  silent_chdir = false,
})

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
  return
end

telescope.load_extension("projects")
