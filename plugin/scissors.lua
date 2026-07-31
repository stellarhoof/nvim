vim.pack.add({ "https://github.com/chrisgrieser/nvim-scissors" }, { confirm = false })

require("scissors").setup({
  backdrop = { enabled = false },
  snippetSelection = { picker = "telescope" },
  icons = { scissors = "" },
})

vim.keymap.set("n", "<leader>ne", function ()
  require("scissors").editSnippet()
end, { desc = "Edit snippet" }
)

vim.keymap.set("n", "<leader>na", function ()
  require("scissors").addNewSnippet()
end, { desc = "Add snippet" }
)

vim.keymap.set("x", "<leader>na", function ()
  require("scissors").addNewSnippet()
end, { desc = "Add snippet from selection" }
)
