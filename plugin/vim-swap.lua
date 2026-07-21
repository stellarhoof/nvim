now(function()
  vim.g.swap_no_default_key_mappings = 1

  vim.pack.add({ "https://github.com/machakann/vim-swap" }, { confirm = false })

  vim.keymap.set("n", "g<", "<plug>(swap-prev)")
  vim.keymap.set("n", "g>", "<plug>(swap-next)")
  vim.keymap.set("o", "i,", "<plug>(swap-textobject-i)")
  vim.keymap.set("x", "i,", "<plug>(swap-textobject-i)")
  vim.keymap.set("o", "a,", "<plug>(swap-textobject-a)")
  vim.keymap.set("x", "a,", "<plug>(swap-textobject-a)")
end)
