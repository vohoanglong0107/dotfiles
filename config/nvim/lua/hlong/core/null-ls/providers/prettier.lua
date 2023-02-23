local utils = require("null-ls.utils").make_conditional_utils()
local project_local_bin = "node_modules/.bin/prettier"
return require("null-ls").builtins.formatting.prettier.with({
	command = utils.root_has_file(project_local_bin) and project_local_bin or "prettier",
	extra_filetypes = { "toml" },
})
