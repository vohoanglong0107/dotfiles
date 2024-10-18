local lspconfig = require("lspconfig")
local mason_lsp_install = require("mason-lspconfig.install")
local mason_registry = require("mason-registry")
local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils").make_conditional_utils()

local base = require("hlong.languages.base")

--- @param package_name string
--- @return string
local function get_binary_path_in_node_modules(package_name)
	return "node_modules/.bin/" .. package_name
end

--- @param package_name string
--- @return boolean
local function is_installed_in_local_node_modules(package_name)
	return null_ls_utils.root_has_file(get_binary_path_in_node_modules(package_name))
end

if is_installed_in_local_node_modules("biome") then
	lspconfig.biome.setup({
		cmd = { get_binary_path_in_node_modules("biome"), "lsp-proxy" },
		capabilities = base.capabilities,
	})
elseif mason_registry.is_installed("biome") then
	lspconfig.biome.setup({
		capabilities = base.capabilities,
	})
end

if is_installed_in_local_node_modules("eslint") then
	local eslint = mason_registry.get_package("eslint-lsp")
	if not eslint:is_installed() then
		mason_lsp_install.install(eslint)
	end
	lspconfig.eslint.setup({
		capabilities = base.capabilities,
	})
end

lspconfig.cssls.setup({
	capabilities = base.capabilities,
})

lspconfig.jsonls.setup({
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
	end,
	capabilities = base.capabilities,
})

lspconfig.ts_ls.setup({
	init_options = {
		preferences = { includeCompletionsForModuleExports = false },
	},
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
	end,
	capabilities = base.capabilities,
})

if is_installed_in_local_node_modules("prettier") then
	null_ls.register({
		null_ls.builtins.formatting.prettier.with({
			command = get_binary_path_in_node_modules("prettier"),
			extra_filetypes = { "toml" },
		}),
	})
end
