local codicons = {
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  Variable = " ",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}

--[[
Get completion context, such as namespace where item is from.
Depending on the LSP, this information is stored in different places.
The process to find them is very manual: log the payloads And see where useful
information is stored.

See https://www.reddit.com/r/neovim/comments/128ndxk/comment/jen9444/?utm_source=share&utm_medium=web2x&context=3
]]
local function get_lsp_completion_context(entry)
  local result = {}
  local ok, server = pcall(function()
    return entry.source.source.client.config.name
  end)
  if ok then
    result.server = server
    if server == "tsserver" then
      result.detail = entry.completion_item.detail
    end
  end
  return result
end

local function format(entry, vim_item)
  vim_item.kind = codicons[vim_item.kind]
  vim_item.menu = get_lsp_completion_context(entry).detail or ""

  -- Truncate or pad `vim_item.abbr`
  local abbr_max_width = 25
  local abbr_width = string.len(vim_item.abbr)
  if abbr_width > abbr_max_width then
    vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, abbr_max_width - 1) .. "…"
  else
    vim_item.abbr = vim_item.abbr .. string.rep(" ", abbr_max_width - abbr_width)
  end

  -- Truncate or pad `vim_item.menu`
  local menu_max_width = 30
  local menu_width = string.len(vim_item.menu)
  if menu_width > menu_max_width then
    vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, menu_max_width - 1) .. "…"
  else
    vim_item.menu = string.rep(" ", menu_max_width - menu_width) .. vim_item.menu
  end

  return vim_item
end

local function lsp_entry_filter(entry)
  local ctx = get_lsp_completion_context(entry)
  -- Filter out imports from specific js libraries
  -- TODO: Make this more customizable
  if
    ctx.server == "tsserver"
    and ctx.detail
    and (vim.startswith(ctx.detail, "lucide-react") or vim.startswith(ctx.detail, "react-icons"))
  then
    return false
  end
  return true
end

return {
  "https://github.com/hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    { "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { "https://github.com/saadparwaiz1/cmp_luasnip" },
  },
  config = function()
    local window = require("cmp").config.window.bordered({
      border = "single",
      winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None,PmenuThumb:PmenuSbar",
    })
    require("cmp").setup({
      sources = require("cmp").config.sources({
        { name = "nvim_lsp", entry_filter = lsp_entry_filter },
        { name = "luasnip" },
      }),
      formatting = {
        expandable_indicator = true,
        fields = { "kind", "abbr", "menu" },
        format = format,
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      completion = {
        keyword_length = 2,
      },
      window = {
        completion = window,
        documentation = window,
      },
      -- performance = {
      -- 	max_view_entries = 30,
      -- },
      mapping = require("cmp").mapping.preset.insert({
        ["<cr>"] = require("cmp").mapping.confirm(),
      }),
    })
  end,
}
