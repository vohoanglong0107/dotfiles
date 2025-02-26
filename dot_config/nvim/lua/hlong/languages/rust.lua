local mason_registry = require("mason-registry")

vim.g.rustaceanvim = {
	server = {
		default_settings = {
			["rust-analyzer"] = {
				inlayHints = {
					typeHints = {
						enable = false,
					},
				},
			},
		},
	},
	tools = {
		hover_actions = {
			replace_builtin_hover = false,
		},
		float_win_config = {
			border = "rounded",
		},
	},
}

local codelldb = mason_registry.get_package("codelldb")
if not codelldb:is_installed() then
	codelldb:install()
end
