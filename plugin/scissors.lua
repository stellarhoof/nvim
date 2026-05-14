G.misc.safely("now", function()
  vim.pack.add({ "https://github.com/chrisgrieser/nvim-scissors" }, { confirm = false })

  require("scissors").setup({
    backdrop = { enabled = false },
    snippetSelection = { picker = "telescope" },
    icons = { scissors = "" },
  })

  G.nmap("<leader>ne", function()
    require("scissors").editSnippet()
  end, { desc = "Edit snippet" })

  G.nmap("<leader>na", function()
    require("scissors").addNewSnippet()
  end, { desc = "Add snippet" })

  G.xmap("<leader>na", function()
    require("scissors").addNewSnippet()
  end, { desc = "Add snippet from selection" })
end)
