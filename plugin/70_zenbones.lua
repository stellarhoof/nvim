G.misc.safely("now", function()
  vim.g.zenbones_darkness = "stark"
  vim.g.zenwritten_darkness = "stark"

  vim.pack.add({
    "https://github.com/rktjmp/lush.nvim",
    "https://github.com/zenbones-theme/zenbones.nvim",
  }, { confirm = false })

  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    desc = "Override zenbones colorscheme highlights",
    pattern = "zen*",
    callback = function()
      vim.api.nvim_set_hl(0, "Folded", {})
      vim.api.nvim_set_hl(0, "Comment", { italic = false, update = true })
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
    end,
  })

  vim.cmd.colorscheme("zenbones")
end)
