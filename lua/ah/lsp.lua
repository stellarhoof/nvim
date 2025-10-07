-- TODO: Check `vim.lsp.inline_completion`

-- Turn off semantic tokens
vim.lsp.semantic_tokens.enable(false)

-- https://github.com/neovim/neovim/issues/32074
vim.lsp.enable({ "vtsls", "biome", "eslint", "lua_ls", "tailwindcss" })

-- https://github.com/jdhao/nvim-config/blob/main/lua/config/lsp.lua
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Temporary until the LSP formatexpr can make comments wrap via `gqq`
    vim.bo[args.buf].formatexpr = nil

    local method = vim.lsp.protocol.Methods

    if client:supports_method(method.workspace_symbol) then
      G.nmap("<leader>lw", vim.lsp.buf.workspace_symbol, {
        unique = false,
        buffer = args.buf,
        desc = "List workspace symbols",
      })
    end

    if client:supports_method(method.workspace_diagnostics) then
      G.nmap("<leader>ld", vim.lsp.buf.workspace_diagnostics, {
        unique = false,
        buffer = args.buf,
        desc = "List workspace diagnostics",
      })
    end
  end,
})
