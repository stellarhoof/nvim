G.misc.safely("now", function()
  vim.g.swap_no_default_key_mappings = 1

  vim.pack.add({ "https://github.com/machakann/vim-swap" }, { confirm = false })

  G.nmap("g<", "<plug>(swap-prev)")
  G.nmap("g>", "<plug>(swap-next)")
  G.omap("i,", "<plug>(swap-textobject-i)")
  G.xmap("i,", "<plug>(swap-textobject-i)")
  G.omap("a,", "<plug>(swap-textobject-a)")
  G.xmap("a,", "<plug>(swap-textobject-a)")
end)
