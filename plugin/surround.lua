G.misc.safely("now", function()
  vim.g.nvim_surround_no_normal_mappings = true

  -- Add/change/delete surrounding delimiter pairs with ease.
  vim.pack.add({ "https://github.com/kylechui/nvim-surround" }, { confirm = false })

  -- https://github.com/ggandor/leap.nvim/discussions/59#discussioncomment-3943323
  -- See `:h nvim-surround.keymaps`
  G.nmap(
    "s",
    "<Plug>(nvim-surround-normal)",
    { desc = "Add a surrounding pair around a motion (normal mode)" }
  )
  G.xmap(
    "s",
    "<Plug>(nvim-surround-visual)",
    { desc = "Add a surrounding pair around a visual selection" }
  )
  G.nmap(
    "ss",
    "<Plug>(nvim-surround-normal-cur)",
    { desc = "Add a surrounding pair around the current line (normal mode)" }
  )
  G.nmap(
    "S",
    "<Plug>(nvim-surround-normal-line)",
    { desc = "Add a surrounding pair around a motion, on new lines (normal mode)" }
  )
  G.xmap(
    "S",
    "<Plug>(nvim-surround-visual-line)",
    { desc = "Add a surrounding pair around a visual selection, on new lines" }
  )
  G.nmap("ds", "<Plug>(nvim-surround-delete)", { desc = "Delete a surrounding pair" })
  G.nmap("cs", "<Plug>(nvim-surround-change)", { desc = "Change a surrounding pair" })
end)
