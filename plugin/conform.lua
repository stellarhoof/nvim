G.misc.safely("now", function()
  vim.pack.add({ "https://github.com/stevearc/conform.nvim" }, { confirm = false })

  require("conform").setup({
    formatters = {
      kulala = {
        command = "kulala-fmt",
        args = { "$FILENAME" },
        stdin = false,
      },
    },
    formatters_by_ft = {
      -- sh = { "shfmt" },
      nix = { "nixfmt" },
      lua = { "stylua" },
      python = { "isort", "black" },
      markdown = { "prettierd" },
      html = { "prettierd" },
      http = { "kulala" },
      svg = { "prettierd" },
      json = { "oxfmt", "prettierd" },
      jsonc = { "oxfmt", "prettierd" },
      javascript = { "oxfmt", "prettierd" },
      javascriptreact = { "oxfmt", "prettierd" },
      typescript = { "oxfmt", "prettierd" },
      typescriptreact = { "oxfmt", "prettierd" },
    },
    default_format_opts = {
      stop_after_first = true,
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = false,
    },
    format_after_save = {
      lsp_fallback = false,
    },
  })
end)
