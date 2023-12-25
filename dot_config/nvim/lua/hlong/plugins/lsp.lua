local servers = {
	bashls = {},
	cssls = {},
	dockerls = {},
	eslint = {},
	jdtls = {}, -- nvim-jdtls is not working
	jsonls = {
		settings = {
			json = {
				schemas = {
					{
						description = "TypeScript compiler configuration file",
						fileMatch = {
							"tsconfig.json",
							"tsconfig.*.json",
						},
						url = "https://json.schemastore.org/tsconfig.json",
					},
					{
						description = "Lerna config",
						fileMatch = { "lerna.json" },
						url = "https://json.schemastore.org/lerna.json",
					},
					{
						description = "Babel configuration",
						fileMatch = {
							".babelrc.json",
							".babelrc",
							"babel.config.json",
						},
						url = "https://json.schemastore.org/babelrc.json",
					},
					{
						description = "ESLint config",
						fileMatch = {
							".eslintrc.json",
							".eslintrc",
						},
						url = "https://json.schemastore.org/eslintrc.json",
					},
					{
						description = "Bucklescript config",
						fileMatch = { "bsconfig.json" },
						url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/8.2.0/docs/docson/build-schema.json",
					},
					{
						description = "Prettier config",
						fileMatch = {
							".prettierrc",
							".prettierrc.json",
							"prettier.config.json",
						},
						url = "https://json.schemastore.org/prettierrc",
					},
					{
						description = "Vercel Now config",
						fileMatch = { "now.json" },
						url = "https://json.schemastore.org/now",
					},
					{
						description = "Stylelint config",
						fileMatch = {
							".stylelintrc",
							".stylelintrc.json",
							"stylelint.config.json",
						},
						url = "https://json.schemastore.org/stylelintrc",
					},
					{
						description = "A JSON schema for the ASP.NET LaunchSettings.json files",
						fileMatch = { "launchsettings.json" },
						url = "https://json.schemastore.org/launchsettings.json",
					},
					{
						description = "Schema for CMake Presets",
						fileMatch = {
							"CMakePresets.json",
							"CMakeUserPresets.json",
						},
						url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json",
					},
					{
						description = "Configuration file as an alternative for configuring your repository in the settings page.",
						fileMatch = {
							".codeclimate.json",
						},
						url = "https://json.schemastore.org/codeclimate.json",
					},
					{
						description = "LLVM compilation database",
						fileMatch = {
							"compile_commands.json",
						},
						url = "https://json.schemastore.org/compile-commands.json",
					},
					{
						description = "Config file for Command Task Runner",
						fileMatch = {
							"commands.json",
						},
						url = "https://json.schemastore.org/commands.json",
					},
					{
						description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
						fileMatch = {
							"*.cf.json",
							"cloudformation.json",
						},
						url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/cloudformation.schema.json",
					},
					{
						description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
						fileMatch = {
							"serverless.template",
							"*.sam.json",
							"sam.json",
						},
						url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/sam.schema.json",
					},
					{
						description = "Json schema for properties json file for a GitHub Workflow template",
						fileMatch = {
							".github/workflow-templates/**.properties.json",
						},
						url = "https://json.schemastore.org/github-workflow-template-properties.json",
					},
					{
						description = "golangci-lint configuration file",
						fileMatch = {
							".golangci.toml",
							".golangci.json",
						},
						url = "https://json.schemastore.org/golangci-lint.json",
					},
					{
						description = "JSON schema for the JSON Feed format",
						fileMatch = {
							"feed.json",
						},
						url = "https://json.schemastore.org/feed.json",
						versions = {
							["1"] = "https://json.schemastore.org/feed-1.json",
							["1.1"] = "https://json.schemastore.org/feed.json",
						},
					},
					{
						description = "Packer template JSON configuration",
						fileMatch = {
							"packer.json",
						},
						url = "https://json.schemastore.org/packer.json",
					},
					{
						description = "NPM configuration file",
						fileMatch = {
							"package.json",
						},
						url = "https://json.schemastore.org/package.json",
					},
					{
						description = "JSON schema for Visual Studio component configuration files",
						fileMatch = {
							"*.vsconfig",
						},
						url = "https://json.schemastore.org/vsconfig.json",
					},
					{
						description = "Resume json",
						fileMatch = { "resume.json" },
						url = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json",
					},
					{
						description = "Devcontainer",
						fileMatch = { "devcontainer.json" },
						url = "https://raw.githubusercontent.com/devcontainers/spec/main/schemas/devContainer.base.schema.json",
					},
				},
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
	ruby_ls = {},
	ruff_lsp = {},
	rust_analyzer = {},
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
				schemas = {
					kubernetes = {
						"configmap.yml",
						"configmap.yaml",
						"deployment.yml",
						"deployment.yaml",
						"hpa.yml",
						"hpa.yaml",
						"service.yml",
						"service.yaml",
						"serviceaccount.yml",
						"serviceaccount.yaml",
					},
					["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
					["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
					["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
					["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
					["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
					["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
					["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
					["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
				},
			},
		},
	},
}

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

-- TODO: remove this after neovim support pull diagnostic
-- https://github.com/Shopify/ruby-lsp/blob/main/EDITORS.md#neovim-lsp
local _timers = {}
local function setup_ruby_diagnostics(client, buffer)
	if require("vim.lsp.diagnostic")._enable then
		return
	end

	local diagnostic_handler = function()
		local params = vim.lsp.util.make_text_document_params(buffer)
		client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
			if err then
				local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
				vim.lsp.log.error(err_msg)
			end
			local diagnostic_items = {}
			if result then
				diagnostic_items = result.items
			end
			vim.lsp.diagnostic.on_publish_diagnostics(
				nil,
				vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
				{ client_id = client.id }
			)
		end)
	end

	diagnostic_handler() -- to request diagnostics on buffer when first attaching

	vim.api.nvim_buf_attach(buffer, false, {
		on_lines = function()
			if _timers[buffer] then
				vim.fn.timer_stop(_timers[buffer])
			end
			_timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
		end,
		on_detach = function()
			if _timers[buffer] then
				vim.fn.timer_stop(_timers[buffer])
			end
		end,
	})
end

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

	if client.name == "ruby_ls" then
		setup_ruby_diagnostics(client, bufnr)
	end

	lsp_keymaps(bufnr)

	setup_auto_format_on_save(client, bufnr)
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
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
