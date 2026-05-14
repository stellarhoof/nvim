G.misc.safely("now", function()
  vim.g.undotree_DiffAutoOpen = 0
  vim.g.undotree_SetFocusWhenToggle = 1
  vim.g.undotree_SplitWidth = 40

  vim.pack.add({ "https://github.com/mbbill/undotree" }, { confirm = false })

  G.nmap("<leader>uu", vim.cmd.UndotreeToggle, { silent = true, desc = "Toggle UndoTree" })
end)
