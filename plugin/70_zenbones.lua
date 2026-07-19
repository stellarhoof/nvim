G.misc.safely("now", function()
  vim.g.zenbones_darkness = "stark"
  vim.g.zenwritten_darkness = "stark"

  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    desc = "Override zenbones colorscheme highlights",
    pattern = "zen*",
    callback = function()
      vim.api.nvim_set_hl(0, "Comment", { italic = false, update = true })
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
    end,
  })

  vim.pack.add({
    -- Lush is a dependency of zenbones
    "https://github.com/rktjmp/lush.nvim",
    "https://github.com/mcchrish/zenbones.nvim",
  }, { confirm = false })
end)
