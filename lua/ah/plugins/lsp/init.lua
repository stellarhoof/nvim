-- [All LSP messages](https://microsoft.github.io/language-server-protocol/specifications/specification-current)

local M = {
  "https://github.com/neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    {
      "https://github.com/hrsh7th/cmp-nvim-lsp",
      { "https://github.com/j-hui/fidget.nvim", tag = "legacy" },
    },
  },
}

function M.on_attach(client, bufnr)
  vim.bo[bufnr].formatexpr = nil -- I prefer no formatexpr

  local desc = function(desc)
    return { buffer = bufnr, desc = desc }
  end

  nmap("<leader>ln", vim.lsp.buf.rename, desc("[L]SP Re[n]ame"))
  nmap("<leader>la", vim.lsp.buf.code_action, desc("[L]sp Code [A]ction"))

  nmap("gd", vim.lsp.buf.definition, desc("[G]oto [D]efinition"))
  nmap("gI", vim.lsp.buf.implementation, desc("[G]oto [I]mplementation"))

  nmap("gr", function()
    require("telescope.builtin").lsp_references()
  end, desc("[G]oto [R]eferences"))

  nmap("g0", function()
    require("telescope.builtin").lsp_document_symbols()
  end, desc("Document Symbols"))

  nmap("gW", function()
    require("telescope.builtin").lsp_dynamic_workspace_symbols()
  end, desc("Workspace Symbols"))

  nmap("K", vim.lsp.buf.hover, desc("Hover Documentation"))
  nmap("<leader>k", vim.lsp.buf.signature_help, desc("Signature Documentation"))

  -- Format document on write
  -- if client.supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
  if client.server_capabilities.documentFormattingProvider then
    au("BufWritePre", {
      desc = "Format buffer on save",
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          bufnr = bufnr,
          filter = function(client)
            -- Never request typescript-language-server for formatting
            return client.name ~= "tsserver"
          end,
        })
      end,
    })
  end
end

local function set_floating_window_defaults(overrides)
  -- Set defaults for LSP floating windows
  local util = require("vim.lsp.util")
  local orig = util.make_floating_popup_options
  util.make_floating_popup_options = function(width, height, opts)
    return vim.tbl_extend("force", orig(width, height, opts), overrides)
  end
end

function M.config()
  require("fidget").setup({
    text = { spinner = "dots" },
    sources = { ["null-ls"] = { ignore = true } },
  })

  require("ah.plugins.lsp.diagnostics").setup()

  set_floating_window_defaults({ noautocmd = true })

  -- Set LSP client's log level. Servers log level is not affected.
  vim.lsp.set_log_level("warn")

  local servers = {
    tsserver = {},
    eslint = {
      on_attach = function(client, bufnr)
        M.on_attach(client, bufnr)
        au("BufWritePre", {
          desc = "Fix buffer on save",
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
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
    -- https://github.com/LuaLS/lua-language-server/wiki/Command-line
    lua_ls = {
      -- This server is CPU hungry and doesn't seem to cache files so when a file
      -- gets edited, the entire workspace gets re-checked.
      -- autostart = false,
      settings = {
        -- https://github.com/LuaLS/vscode-lua/blob/master/setting/schema.json
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            -- Do not send telemetry data containing a randomized but unique identifier
            enable = false,
          },
        },
      },
    },
    -- https://github.com/olrtg/emmet-language-server
    -- https://github.com/olrtg/nvim-emmet
    emmet_language_server = {
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
      -- Read more about this options in the
      -- [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
      -- NOTE: Only the options listed in the table are supported.
      init_options = {
        ---@type table<string, string>
        includeLanguages = {},
        --- @type string[]
        excludeLanguages = {},
        --- @type string[]
        extensionsPath = {},
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
        preferences = {},
        --- @type boolean Defaults to `true`
        showAbbreviationSuggestions = true,
        --- @type "always" | "never" Defaults to `"always"`
        showExpandedAbbreviation = "always",
        --- @type boolean Defaults to `false`
        showSuggestionsAsSnippets = false,
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
        syntaxProfiles = {},
        --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
        variables = {},
      },
    },
  }

  for name, opts in pairs(servers) do
    require("lspconfig")[name].setup(vim.tbl_extend("force", {
      on_attach = M.on_attach,
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    }, opts))
  end
end

return M
