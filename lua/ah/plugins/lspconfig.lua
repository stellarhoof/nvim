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

  -- Methods that show lists

  if client:supports_method(method.workspace_symbol) then
    G.nmap("<leader>lw", vim.lsp.buf.workspace_symbol, {
      unique = false,
      buffer = bufnr,
      desc = "List workspace symbols",
    })
  end
  if client:supports_method(method.textDocument_typeDefinition) then
    G.nmap("<leader>lt", vim.lsp.buf.type_definition, {
      unique = false,
      buffer = bufnr,
      desc = "List current symbol type definitions",
    })
  end
  if client:supports_method(method.typeHierarchy_subtypes) then
    G.nmap("<leader>lh", function()
      vim.lsp.buf.typehierarchy("subtypes")
    end, {
      unique = false,
      buffer = bufnr,
      desc = "List current symbol type hierarchy",
    })
  end
end

local function disable_inside_node_modules(name)
  return function(filename, bufnr)
    -- Disable if file is inside node_modules
    if string.find(filename, "node_modules/") then
      return nil
    end
    local config = require(string.format("lspconfig.configs.%s", name))
    return config.default_config.root_dir(filename, bufnr)
  end
end

local function typescript_root_dir(filename)
  local root_pattern = require("lspconfig.util").root_pattern

  -- Sounds like a good idea until you realize you can't jump to definitions
  -- from library to library :(
  -- -- Disable if file is inside node_modules
  -- if string.find(filename, "node_modules/") then
  -- 	return nil
  -- end

  -- Support monorepos by resolving to the root project
  local dir = root_pattern(".git")(filename)
  if dir and vim.fn.globpath(dir, "tsconfig.json") ~= "" then
    return dir
  end

  return root_pattern("tsconfig.json", ".git", "jsconfig.json", "package.json")(filename)
end

local servers = {
  -- tsserver = {
  -- 	root_dir = typescript_root_dir,
  -- 	single_file_support = false,
  -- },
  -- TODO: Investigate https://github.com/pmizio/typescript-tools.nvim
  vtsls = {
    root_dir = typescript_root_dir,
    single_file_support = false,
    -- https://github.com/yioneko/vtsls/blob/41ad8c9d3f9dbd122ce3259564f34d020b7d71d9/packages/service/configuration.schema.json
    settings = {
      typescript = {
        updateImportsOnFileMove = "always",
        preferTypeOnlyAutoImports = true,
        tsserver = {
          maxTsServerMemory = 6144,
        },
      },
      vtsls = {
        -- https://github.com/yioneko/vtsls#typescript-version
        autoUseWorkspaceTsdk = true,
        enableMoveToFileCodeAction = true,
        -- This may make completions more performant
        -- experimental.completion.enableServerSideFuzzyMatch
      },
    },
    on_attach = function(_, bufnr)
      -- Neovim core picked `cr` as a prefix for refactors

      G.nmap("grs", require("vtsls").commands.source_actions, {
        buffer = bufnr,
        desc = "Select source action",
      })

      G.nmap("grm", function()
        local old_fpath = vim.fn.expand("%")
        vim.ui.input({
          prompt = "Rename file and update imports",
          default = old_fpath,
        }, function(new_fpath)
          require("vtsls").rename(
            vim.fn.fnamemodify(old_fpath, ":p"),
            vim.fn.fnamemodify(new_fpath, ":p")
          )
        end)
      end, {
        buffer = bufnr,
        desc = "Rename file",
      })

      -- Non refactoring mappings

      G.nmap("<leader>li", require("vtsls").commands.file_references, {
        buffer = bufnr,
        desc = "List sites where current file is imported",
      })

      G.nmap("gd", require("vtsls").commands.goto_source_definition, {
        buffer = bufnr,
        desc = "Goto source definition of symbol under cursor",
      })
    end,
  },
  biome = {
    root_dir = disable_inside_node_modules("biome"),
    cmd = { "biome", "lsp-proxy", "--config-path", "biome.jsonc" },
  },
  eslint = {
    root_dir = disable_inside_node_modules("eslint"),
    on_attach = function(_, bufnr)
      G.au("BufWritePre", { buffer = bufnr, command = "EslintFixAll", desc = "Fix buffer on save" })
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
    {
      "https://github.com/yioneko/nvim-vtsls",
    },
  },
  init = function()
    G.nmap("<leader>lf", vim.cmd.LspInfo, { desc = "Show configured clients for current buffer" })
  end,
  config = function()
    -- https://github.com/hrsh7th/cmp-nvim-lsp/issues/38#issuecomment-1815265121
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    for name, opts in pairs(servers) do
      require("lspconfig")[name].setup(G.merge(opts, {
        capabilities = G.merge(
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
