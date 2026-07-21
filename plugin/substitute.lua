now(function()
  -- Operators to substitute and exchange text.
  -- Lua version of
  --  https://github.com/svermeulen/vim-subversive
  --  https://github.com/tommcdo/vim-exchange
  vim.pack.add({ "https://github.com/gbprod/substitute.nvim" }, { confirm = false })

  require("substitute").setup({ highlight_substituted_text = { enabled = false } })

  vim.keymap.set("n", "gs", function()
    require("substitute").operator()
  end, { noremap = true, desc = "Substitute text object with contents of default register" })

  vim.keymap.set("n", "gss", function()
    require("substitute").line()
  end, { noremap = true, desc = "Substitute line with contents of default register" })

  vim.keymap.set("n", "gS", function()
    require("substitute").eol()
  end, { noremap = true, desc = "Substitute up to EOL with contents of default register" })

  vim.keymap.set("x", "gs", function()
    require("substitute").visual()
  end, { noremap = true, desc = "Substitute visual selection with contents of default register" })

  vim.keymap.set("n", "ge", function()
    require("substitute.exchange").operator()
  end, { noremap = true, desc = "Exchange with text object" })

  vim.keymap.set("n", "gee", function()
    require("substitute.exchange").line()
  end, { noremap = true, desc = "Exchange with line" })

  vim.keymap.set("n", "gE", function()
    require("substitute.exchange").cancel()
  end, { noremap = true, desc = "Exchange up to EOL" })

  vim.keymap.set("x", "ge", function()
    require("substitute.exchange").visual()
  end, { noremap = true, desc = "Exchange with visual selection" })
end)
