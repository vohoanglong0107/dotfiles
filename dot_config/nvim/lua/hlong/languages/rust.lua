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
