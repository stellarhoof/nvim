local M = {
  "https://github.com/hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/onsails/lspkind.nvim",
    "https://github.com/hrsh7th/cmp-path",
    { "https://github.com/zbirenbaum/copilot.lua", event = "InsertEnter" },
    "https://github.com/zbirenbaum/copilot-cmp",
  },
}

function M.config()
  require("lspkind").init({
    symbol_map = vim.tbl_extend("error", require("ah.plugins.lsp.icons").kind, {
      Copilot = " ",
    }),
  })

  require("cmp").setup({
    completion = {
      autocomplete = false, -- Do not autocomplete as you type
      completeopt = "menu,menuone,select",
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = require("lspkind").cmp_format({ mode = "symbol" }),
    },
    sources = require("cmp").config.sources({
      { name = "copilot",  group_index = 2 },
      { name = "nvim_lsp", group_index = 2 },
      { name = "buffer",   group_index = 2 },
      { name = "path",     group_index = 2 },
    }),
    snippet = {
      expand = function() end,
    },
    mapping = require("cmp").mapping.preset.insert({
      -- Pick selected entry
      ["<cr>"] = require("cmp").mapping.confirm(),
      -- Trigger completion if no menu is open. Otherwise select next item
      ["<c-n>"] = function()
        local cmp = require("cmp")
        if not cmp.visible() then
          cmp.complete()
        else
          cmp.select_next_item()
        end
      end,
    }),
  })

  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })

  require("copilot_cmp").setup()
end

return M
