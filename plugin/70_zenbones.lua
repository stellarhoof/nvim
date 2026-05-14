G.misc.safely("now", function()
  vim.g.zenbones_darkness = "stark"
  vim.g.zenwritten_darkness = "stark"

  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    desc = "Override zenbones colorscheme highlights",
    pattern = "zen*",
    callback = function()
      G.hl_update("Constant", { italic = false })
      G.hl_update("Comment", { italic = false })
      G.hl_link("FloatBorder", "NormalFloat")
      G.hl_link("FloatTitle", "NormalFloat", { bold = true })
    end,
  })

  vim.pack.add({
    -- Lush is a dependency of zenbones
    "https://github.com/rktjmp/lush.nvim",
    "https://github.com/mcchrish/zenbones.nvim",
  }, { confirm = false })
end)
