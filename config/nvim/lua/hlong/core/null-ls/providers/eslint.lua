local utils = require("null-ls.utils").make_conditional_utils()
local project_local_bin = "node_modules/.bin/eslint"
return require("null-ls").builtins.diagnostics.eslint.with({
	command = utils.root_has_file(project_local_bin) and project_local_bin or "eslint",
})
