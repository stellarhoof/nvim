now(function()
  vim.g.nvim_surround_no_normal_mappings = true

  -- Add/change/delete surrounding delimiter pairs with ease.
  vim.pack.add({ "https://github.com/kylechui/nvim-surround" }, { confirm = false })

  -- https://github.com/ggandor/leap.nvim/discussions/59#discussioncomment-3943323
  -- See `:h nvim-surround.keymaps`
  vim.keymap.set(
    "n",
    "s",
    "<Plug>(nvim-surround-normal)",
    { desc = "Add a surrounding pair around a motion (normal mode)" }
  )
  vim.keymap.set(
    "x",
    "s",
    "<Plug>(nvim-surround-visual)",
    { desc = "Add a surrounding pair around a visual selection" }
  )
  vim.keymap.set(
    "n",
    "ss",
    "<Plug>(nvim-surround-normal-cur)",
    { desc = "Add a surrounding pair around the current line (normal mode)" }
  )
  vim.keymap.set(
    "n",
    "S",
    "<Plug>(nvim-surround-normal-line)",
    { desc = "Add a surrounding pair around a motion, on new lines (normal mode)" }
  )
  vim.keymap.set(
    "x",
    "S",
    "<Plug>(nvim-surround-visual-line)",
    { desc = "Add a surrounding pair around a visual selection, on new lines" }
  )
  vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)", { desc = "Delete a surrounding pair" })
  vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)", { desc = "Change a surrounding pair" })
end)
