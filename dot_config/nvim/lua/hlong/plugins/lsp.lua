local ensure_installed = {
	"bashls",
	"cssls",
	"dockerls",
	"jsonls",
	"pyright",
	"lua_ls",
	"tsserver",
	"yamlls",
}

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "󰌵" },
	{ name = "DiagnosticSignInfo", text = "" },
}

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "<leader>ll", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
	keymap(bufnr, "n", "<leader>lI", "<cmd>LspInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<leader>lq", "<cmd>Trouble document_diagnostics<CR>", opts)
end

local lspconfig_group = vim.api.nvim_create_augroup("LspConfig", { clear = true })

local function setup_auto_format_on_save(client, bufnr)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "<buffer>",
			callback = function()
				vim.lsp.buf.format({ async = false, timeout = 2000 })
			end,
			group = lspconfig_group,
		})
	end
end

local function disable_formatting_selected_server(client, bufnr)
	local disable_formatting = {
		eslint = true,
		jsonls = true,
		lua_ls = true,
		tsserver = true,
	}
	if disable_formatting[client.name] then
		client.server_capabilities.documentFormattingProvider = false
	end
end

local function disable_yamlls_on_helm(client, bufnr)
	if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
		vim.diagnostic.disable(bufnr)
	end
end

local function disable_hover_ruff(client, bufnr)
	client.server_capabilities.hoverProvider = false
end

local on_attach = function(client, bufnr)
	disable_formatting_selected_server(client, bufnr)
	if client.name == "ruff_lsp" then
		disable_hover_ruff(client, bufnr)
	end
	if client.name == "yamlls" then
		disable_yamlls_on_helm(client, bufnr)
	end

	lsp_keymaps(bufnr)

	setup_auto_format_on_save(client, bufnr)
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"b0o/schemastore.nvim",
		"folke/neoconf.nvim",
		"folke/neodev.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
		"williamboman/mason.nvim",
	},
	config = function()
		for _, sign in ipairs(signs) do
			vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
		end
		vim.diagnostic.config({
			signs = {
				active = signs, -- show signs
			},
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		require("neoconf").setup()
		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
		})
		require("neodev").setup({
			override = function(root_dir, library)
				if string.find(root_dir, "nvim") ~= nil then
					library.enabled = true
					library.plugins = true
				end
			end,
		})

		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

		local servers = {
			bashls = {},
			biome = {},
			cssls = {},
			dockerls = {},
			jdtls = {}, -- nvim-jdtls is not working
			jsonls = {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
				setup = {
					commands = {
						Format = {
							function()
								vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
							end,
						},
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = "Disable",
						},
					},
				},
			},
			pyright = {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
						},
					},
				},
			},
			ruby_lsp = {},
			ruff_lsp = {},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			},
			terraformls = {},
			tflint = {},
			tsserver = {
				init_options = {
					preferences = { includeCompletionsForModuleExports = false },
				},
			},
			yamlls = {
				settings = {
					yaml = {
						schemastore = { enable = true },
					},
				},
			},
		}

		for server, opts in pairs(servers) do
			opts = vim.tbl_deep_extend("force", opts, {
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig[server].setup(opts)
		end
		require("lspconfig.ui.windows").default_options.border = "rounded"
	end,
}
