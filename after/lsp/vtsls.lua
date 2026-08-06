---@type vim.lsp.Config
return {
  -- TODO: Why don't the types work here?
  -- https://github.com/yioneko/vtsls/blob/41ad8c9d3f9dbd122ce3259564f34d020b7d71d9/packages/service/configuration.schema.json
  ---@type lspconfig.settings.vtsls
  settings = {
    typescript = {
      updateImportsOnFileMove = "always",
      preferTypeOnlyAutoImports = true,
      tsserver = { maxTsServerMemory = 8192 },
    },
    javascript = {
      updateImportsOnFileMove = "always",
    },
    vtsls = {
      -- https://github.com/yioneko/vtsls#typescript-version
      autoUseWorkspaceTsdk = true,
    },
  },
  on_attach = function (client, bufnr)
    -- Disable formatting capabilities. We'll be using a dedicated formatter
    -- instead.
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
