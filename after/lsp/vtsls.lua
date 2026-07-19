return {
  -- https://github.com/yioneko/vtsls/blob/41ad8c9d3f9dbd122ce3259564f34d020b7d71d9/packages/service/configuration.schema.json
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
  on_attach = function(_, bufnr)
    vim.keymap.set("n", "grf", require("vtsls").commands.file_references, {
      buffer = bufnr,
      desc = "[vtsls] commands.file_references",
    })

    vim.keymap.set("n", "grs", require("vtsls").commands.source_actions, {
      buffer = bufnr,
      desc = "[vtsls] commands.source_actions",
    })

    vim.keymap.set("n", "grm", require("vtsls").commands.rename_file, {
      buffer = bufnr,
      desc = "[vtsls] commands.rename_file",
    })

    vim.keymap.set("n", "gd", require("vtsls").commands.goto_source_definition, {
      buffer = bufnr,
      desc = "[vtsls] commands.goto_source_definition",
    })
  end,
}
