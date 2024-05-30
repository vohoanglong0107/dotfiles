local base = require("hlong.languages.base")
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils").make_conditional_utils()

lspconfig.biome.setup({
	on_attach = function(client, bufnr)
		base.setup_default_keymaps(bufnr)
		base.setup_auto_format_on_save(client)
	end,
	capabilities = base.capabilities,
})

lspconfig.cssls.setup({
	on_attach = function(_, bufnr)
		base.setup_default_keymaps(bufnr)
	end,
	capabilities = base.capabilities,
})

lspconfig.jsonls.setup({
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
	on_attach = function(_, bufnr)
		base.setup_default_keymaps(bufnr)
	end,
	capabilities = base.capabilities,
})

lspconfig.tsserver.setup({
	init_options = {
		preferences = { includeCompletionsForModuleExports = false },
	},
	on_attach = function(_, bufnr)
		base.setup_default_keymaps(bufnr)
	end,
	capabilities = base.capabilities,
})

if null_ls_utils.root_has_file("node_modules/.bin/eslint") then
	null_ls.register({
		null_ls.builtins.formatting.eslint.with({
			command = "node_modules/.bin/eslint",
		}),
		null_ls.builtins.diagnostics.eslint.with({
			command = "node_modules/.bin/eslint",
		}),
	})
end

if null_ls_utils.root_has_file("node_modules/.bin/prettier") then
	null_ls.register({
		null_ls.builtins.formatting.prettier.with({
			command = "node_modules/.bin/prettier",
			extra_filetypes = { "toml" },
		}),
	})
end
