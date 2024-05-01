-- [All LSP messages](https://microsoft.github.io/language-server-protocol/specifications/specification-current)

-- :h lsp-api
-- Also see $VIMRUNTIME/lua/vim/lsp.lua:315 for defaults.
local function on_attach(client, bufnr)
	-- Temporary until the LSP formatexpr can make comments wrap via `gqq`
	vim.bo[bufnr].formatexpr = nil

	-- Turn off semantic tokens
	client.server_capabilities.semanticTokensProvider = nil

	local method = vim.lsp.protocol.Methods

	-- TODO
	-- Search diagnostics (maybe with trouble?)
	-- CodeLens?
	-- Symbols outline (left tree)
	-- Nicer UI for methods that display quickfix lists?

	if client.supports_method(method.textDocument_codeAction) then
		nmap("<leader>la", vim.lsp.buf.code_action, {
			unique = false,
			buffer = bufnr,
			desc = "Code action",
		})
	end
	if client.supports_method(method.textDocument_rename) then
		nmap("<leader>ln", vim.lsp.buf.rename, {
			unique = false,
			buffer = bufnr,
			desc = "Rename symbol",
		})
	end

	-- Methods that show lists

	if client.supports_method(method.textDocument_documentSymbol) then
		nmap("<leader>ls", vim.lsp.buf.document_symbol, {
			unique = false,
			buffer = bufnr,
			desc = "List document symbols to quickfix list",
		})
	end
	if client.supports_method(method.workspace_symbol) then
		nmap("<leader>lw", vim.lsp.buf.workspace_symbol, {
			unique = false,
			buffer = bufnr,
			desc = "List workspace symbols to quickfix list",
		})
	end
	if client.supports_method(method.textDocument_implementation) then
		nmap("<leader>lm", vim.lsp.buf.implementation, {
			unique = false,
			buffer = bufnr,
			desc = "List current symbol implementations to quickfix list",
		})
	end
	if client.supports_method(method.textDocument_references) then
		nmap("<leader>lr", vim.lsp.buf.references, {
			unique = false,
			buffer = bufnr,
			desc = "List current symbol references to quickfix list",
		})
	end
	if client.supports_method(method.callHierarchy_incomingCalls) then
		nmap("<leader>li", vim.lsp.buf.incoming_calls, {
			unique = false,
			buffer = bufnr,
			desc = "List current symbol incoming calls to quickfix list",
		})
	end
	if client.supports_method(method.callHierarchy_outgoingCalls) then
		nmap("<leader>lo", vim.lsp.buf.outgoing_calls, {
			unique = false,
			buffer = bufnr,
			desc = "List current symbol outgoing calls to quickfix list",
		})
	end
	if client.supports_method(method.textDocument_typeDefinition) then
		nmap("<leader>lt", vim.lsp.buf.type_definition, {
			unique = false,
			buffer = bufnr,
			desc = "List current symbol type definitions to quickfix list",
		})
	end
	if client.supports_method(method.typeHierarchy_subtypes) then
		nmap("<leader>lh", function()
			vim.lsp.buf.typehierarchy("subtypes")
		end, {
			unique = false,
			buffer = bufnr,
			desc = "List current symbol type hierarchy to quickfix list",
		})
	end
end

local function disable_inside_node_modules(name)
	return function(filename, bufnr)
		-- Disable if file is inside node_modules
		if string.find(filename, "node_modules/") then
			return nil
		end
		local config = require(string.format("lspconfig.server_configurations.%s", name))
		return config.default_config.root_dir(filename, bufnr)
	end
end

local servers = {
	tsserver = {
		root_dir = function(filename)
			local root_pattern = require("lspconfig.util").root_pattern

			-- Disable if file is inside node_modules
			if string.find(filename, "node_modules/") then
				return nil
			end

			-- Support monorepos by resolving to the root project
			local dir = root_pattern(".git")(filename)
			if dir and vim.fn.globpath(dir, "tsconfig.json") ~= "" then
				return dir
			end

			return root_pattern("tsconfig.json", ".git", "jsconfig.json", "package.json")(filename)
		end,
		single_file_support = false,
	},
	biome = {
		cmd = { "biome", "lsp-proxy", "--config-path", "biome.jsonc" },
	},
	eslint = {
		root_dir = disable_inside_node_modules("eslint"),
		on_attach = function(client, bufnr)
			au(
				"BufWritePre",
				{ buffer = bufnr, command = "EslintFixAll", desc = "Fix buffer on save" }
			)
		end,
	},
	-- https://github.com/olrtg/emmet-language-server
	-- https://github.com/olrtg/nvim-emmet
	emmet_language_server = {
		root_dir = disable_inside_node_modules("emmet_language_server"),
		single_file_support = false,
		filetypes = {
			"css",
			"eruby",
			"html",
			"javascript",
			"javascriptreact",
			"less",
			"sass",
			"scss",
			"pug",
			"typescriptreact",
		},
	},
	rescriptls = {
		cmd = { "rescript-lsp", "--stdio" },
	},
	pylsp = {
		settings = {
			pylsp = {
				plugins = {
					pyflakes = { enabled = false },
					pycodestyle = { enabled = false },
					mccabe = { enabled = false },
					autopep8 = { enabled = false },
					yapf = { enabled = false },
				},
			},
		},
	},
	-- Configured by https://github.com/folke/neodev.nvim
	lua_ls = {},
}

return {
	"https://github.com/neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		{
			"https://github.com/folke/neodev.nvim",
			opts = {},
		},
	},
	init = function()
		nmap("<leader>lf", vim.cmd.LspInfo, { desc = "Show configured clients for current buffer" })
	end,
	config = function()
		-- https://github.com/hrsh7th/cmp-nvim-lsp/issues/38#issuecomment-1815265121
		local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		for name, opts in pairs(servers) do
			require("lspconfig")[name].setup(merge(opts, {
				capabilities = merge(
					{},
					vim.lsp.protocol.make_client_capabilities(),
					-- cmp.nvim
					has_cmp and cmp_nvim_lsp.default_capabilities() or {},
					-- nvim-ufo
					{
						textDocument = {
							foldingRange = {
								dynamicRegistration = false,
								lineFoldingOnly = true,
							},
						},
					},
					opts.capabilities or {}
				),
				on_attach = function(...)
					on_attach(...)
					if opts.on_attach then
						opts.on_attach(...)
					end
				end,
			}))
		end
	end,
}
