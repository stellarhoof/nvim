local M = {
  "https://github.com/L3MON4D3/LuaSnip",
  event = "InsertEnter",
}

function M.config()
  local luasnip = require("luasnip")

  -- Include rhs snippets in lhs filetypes
  luasnip.filetype_extend("javascriptreact", { "javascript" })
  luasnip.filetype_extend("typescript", { "javascript" })
  luasnip.filetype_extend("typescriptreact", { "javascript" })

  require("luasnip.loaders.from_snipmate").lazy_load({
    paths = { root .. "/lua/ah/plugins/luasnip/snippets" },
  })

  -- Use tab in visual mode to wrap stuff in snippets
  luasnip.config.setup({ store_selection_keys = "<tab>" })

  map({ "i", "s" }, "<tab>", function()
    return luasnip.expand_or_jumpable() and "<plug>luasnip-expand-or-jump" or "<tab>"
  end, { silent = true, expr = true, desc = "Expand or jump in snippet" })

  map({ "i", "s" }, "<s-tab>", function()
    require("luasnip").jump(-1)
  end, { silent = true, desc = "Jump backwards in snippet" })

  map({ "i", "s" }, "<c-tab>", function()
    return luasnip.choice_active() and "<plug>luasnip-next-choice" or "<c-tab>"
  end, { silent = true, expr = true, desc = "Select choice in snippet" })
end

return M
