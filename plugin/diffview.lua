G.misc.safely("now", function()
  vim.pack.add({ "https://github.com/dlyongemallo/diffview-plus.nvim" }, { confirm = false })
  vim.cmd.Alias({ args = { "dt", "DiffviewToggle" } })
end)
