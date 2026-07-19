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
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
})
