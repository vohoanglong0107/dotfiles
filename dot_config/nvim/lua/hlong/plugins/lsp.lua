local ensure_installed = {
	"bashls",
	"cssls",
	"dockerls",
	"jsonls",
	"pyright",
	"lua_ls",
	"ts_ls",
	"yamlls",
}

return {
	{
		"neovim/nvim-lspconfig",
		lazy = false, -- too many plugins depend on this, lazy loading it will cause issues
		dependencies = {
			"b0o/schemastore.nvim",
			"folke/neoconf.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
		config = function()
			require("neoconf").setup()
			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
			})

			require("lspconfig.ui.windows").default_options.border = "rounded"
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"jayp0521/mason-null-ls.nvim",
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"golangci_lint",
					"prettier",
					"shfmt",
				},
				automatic_installation = true,
			})

			local null_ls = require("null-ls")

			null_ls.setup({
				border = "rounded",
				debounce = 1000,
				debug = false,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "",
						package_pending = "󰁇",
						package_uninstalled = "",
					},
				},
				log_level = vim.log.levels.INFO,
				max_concurrent_installers = 4,
			})
		end,
	},
	--- Enhance LuaLS
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		dependencies = {
			"Bilal2453/luvit-meta",
		},
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	--- Displaying diagnostics, moving around LSP symbols
	{ "folke/trouble.nvim", cmd = { "Trouble" }, opts = {} },
}
