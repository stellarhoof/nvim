-- TODO: Enable LSP progress. See
-- https://github.com/nvim-mini/mini.nvim/blob/946ae64e0ee807ae3c41f382f0114b4ed4915b2c/lua/mini/notify.lua#L685
-- and |progress-message|

-- Quickstart configs for neovim's native lsp.
later(function ()
  vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" }, { confirm = false })
  vim.lsp.enable({ "emmylua_ls", "nixd", "oxfmt", "oxlint", "tailwindcss", "vtsls" })
end)

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  callback = function (ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    assert(client, "no lsp client")

    -- Temporary until the LSP formatexpr can make comments wrap via `gqq`
    vim.bo[ev.buf].formatexpr = nil

    -- Not a big fan of semantic tokens.
    vim.lsp.semantic_tokens.enable(false, { bufnr = ev.buf })

    if client:supports_method("workspace/symbol") then
      vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol, {
        unique = false,
        buffer = ev.buf,
        desc = "List workspace symbols",
      })
    end

    if client:supports_method("workspace/diagnostic") then
      vim.keymap.set("n", "<leader>ld", vim.lsp.buf.workspace_diagnostics, {
        unique = false,
        buffer = ev.buf,
        desc = "List workspace diagnostics",
      })
    end

    -- Format buffer on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method("textDocument/willSaveWaitUntil")
      and client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = ev.buf,
        callback = function ()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
