now(function()
  vim.pack.add({
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  }, { confirm = false })

  require("mason").setup()

  require("mason-tool-installer").setup({
    ensure_installed = {
      -- LSP
      "eslint-lsp",
      "lua-language-server",
      "tailwindcss-language-server",
      "vtsls",
      -- Formatters
      "prettierd",
      "stylua",
      "shfmt",
      "isort",
      "black",
      "jq",
      -- DAP
      "js-debug-adapter",
    },
  })
end)
