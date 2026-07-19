G.misc.safely("now", function()
  vim.pack.add({ "https://github.com/chrisgrieser/nvim-various-textobjs" }, { confirm = false })

  local textobj = require("various-textobjs")

  -- Surrounding lines with same or higher indentation
  vim.keymap.set({ "o", "x" }, "ii", function()
    textobj.indentation("inner", "inner")
  end, { desc = "inner indented block" })

  vim.keymap.set({ "o", "x" }, "ai", function()
    textobj.indentation("outer", "outer")
  end, { desc = "outer indented block" })

  -- Like iw, but treating -, _, and . as word delimiters and only part of camelCase
  vim.keymap.set({ "o", "x" }, "iv", function()
    textobj.subword("inner")
  end, { desc = "inner subword" })

  vim.keymap.set({ "o", "x" }, "av", function()
    textobj.subword("outer")
  end, { desc = "outer subword" })

  -- Between any unescaped ", ', or ` in a line
  vim.keymap.set({ "o", "x" }, "iq", function()
    textobj.anyQuote("inner")
  end, { desc = "inner quote in a line" })

  vim.keymap.set({ "o", "x" }, "aq", function()
    textobj.anyQuote("outer")
  end, { desc = "outer quote in a line" })
end)
