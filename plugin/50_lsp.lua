vim.lsp.semantic_tokens.enable(false)

-- https://github.com/neovim/neovim/issues/32074
vim.lsp.enable({
  "emmylua_ls",
  "nixd",
  "oxfmt",
  "oxlint",
  "tailwindcss",
  "vtsls",
})

-- TODO: Enable LSP progress. See
-- https://github.com/nvim-mini/mini.nvim/blob/946ae64e0ee807ae3c41f382f0114b4ed4915b2c/lua/mini/notify.lua#L685
-- and |progress-message|
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  callback = function (args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Temporary until the LSP formatexpr can make comments wrap via `gqq`
    vim.bo[args.buf].formatexpr = nil

    local method = vim.lsp.protocol.Methods

    if client:supports_method(method.workspace_symbol) then
      vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol, {
        unique = false,
        buffer = args.buf,
        desc = "List workspace symbols",
      })
    end

    if client:supports_method(method.workspace_diagnostics) then
      vim.keymap.set("n", "<leader>ld", vim.lsp.buf.workspace_diagnostics, {
        unique = false,
        buffer = args.buf,
        desc = "List workspace diagnostics",
      })
    end
  end,
})
