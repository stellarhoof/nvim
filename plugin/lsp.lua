-- TODO: Enable LSP progress. See
-- https://github.com/nvim-mini/mini.nvim/blob/946ae64e0ee807ae3c41f382f0114b4ed4915b2c/lua/mini/notify.lua#L685
-- and |progress-message|

-- Quickstart configs for neovim's native lsp.
later(function ()
  vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" }, { confirm = false })
  vim.lsp.enable({ "emmylua_ls", "oxfmt", "oxlint", "tailwindcss", "vtsls" })
end)

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  callback = function (ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    assert(client, "no lsp client")

    -- Not a big fan of semantic tokens.
    vim.lsp.semantic_tokens.enable(false, { bufnr = ev.buf })

    -- The LSP server decides the "workspace root" of a buffer,
    -- but the Nvim |current-directory| does not follow it, so
    -- commands like |:make|, |:grep| and |:terminal| do not run
    -- from the workspace root. Use |:bcd| to sync each buffer's
    -- directory to its LSP workspace root. See |lsp-buf-working-dir|
    -- if client.root_dir then
    --   vim.cmd.bcd(client.root_dir)
    -- end

    if client:supports_method("workspace/symbol") then
      vim.keymap.set("n", "<leader>lws", vim.lsp.buf.workspace_symbol, {
        unique = false,
        buffer = ev.buf,
        desc = "List workspace symbols",
      })
    end

    if client:supports_method("textDocument/documentSymbol") then
      vim.keymap.set("n", "<leader>lds", vim.lsp.buf.document_symbol, {
        unique = false,
        buffer = ev.buf,
        desc = "List document symbols",
      })
    end

    if client:supports_method("workspace/diagnostic") then
      vim.keymap.set("n", "<leader>lwd", vim.lsp.buf.workspace_diagnostics, {
        unique = false,
        buffer = ev.buf,
        desc = "List workspace diagnostics",
      })
    end
  end,
})
