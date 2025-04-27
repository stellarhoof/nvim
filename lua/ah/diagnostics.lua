vim.diagnostic.config({
  virtual_text = false,
  float = { source = true },
  jump = {
    wrap = false,
    float = true,
    severity = { min = vim.diagnostic.severity.HINT },
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
})

G.nmap("<leader>dd", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "Toggle diagnostics for current buffer" })

G.nmap(
  "<leader>dl",
  vim.diagnostic.setloclist,
  { desc = "Add current buffer diagnostics to loclist" }
)

G.nmap(
  "<leader>dq",
  vim.diagnostic.setqflist,
  { desc = "Add all buffers diagnostics to quickfix list" }
)
