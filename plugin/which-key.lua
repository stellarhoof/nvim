G.misc.safely("now", function()
  vim.pack.add({ "https://github.com/folke/which-key.nvim" }, { confirm = false })

  require("which-key").setup({
    delay = 500,
    icons = { mappings = false },
    plugins = { marks = false, registers = false },
  })

  require("which-key").add({
    { "<leader>d", group = "Diagnostics" },
    { "<leader>l", group = "LSP" },
    { "<leader>u", group = "UI" },
  })
end)
