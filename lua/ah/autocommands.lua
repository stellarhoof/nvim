local group = G.aug("init", {})

-- https://github.com/neovim/neovim/issues/1936
G.au({ "FocusGained", "TermClose", "TermLeave" }, {
  group = group,
  desc = "Autoread current file",
  command = "checktime",
})

-- :h lua-highlight
G.au({ "TextYankPost" }, {
  group = group,
  desc = "Highlight yanked text",
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
})

G.au({ "BufReadPost" }, {
  group = group,
  desc = "Go to last location when opening a buffer",
  callback = function(event)
    local ignore_buftype = { "quickfix", "nofile", "help" }
    local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }
    local buf = event.buf
    if
      vim.tbl_contains(ignore_buftype, vim.bo[buf].buftype)
      or vim.tbl_contains(ignore_filetype, vim.bo[buf].filetype)
      or vim.b[buf].last_loc
    then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

G.au({ "BufWritePre" }, {
  group = group,
  desc = "Create missing directories when saving a file",
  callback = function(event)
    if not event.match:match("^%w%w+://") then
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end
  end,
})

G.au({ "ColorScheme" }, {
  group = group,
  desc = "Override general colorscheme highlights",
  callback = function()
    G.hl_clear("Folded")
    G.hl_link("FloatBorder", "NormalFloat")
    G.hl_link("FloatTitle", "NormalFloat", { bold = true })
    G.hl_update("Directory", { bold = true })
    G.hl_update("DiagnosticUnderlineHint", { undercurl = true })
    G.hl_update("DiagnosticUnderlineInfo", { undercurl = true })
    G.hl_update("DiagnosticUnderlineWarn", { undercurl = true })
    G.hl_update("DiagnosticUnderlineError", { undercurl = true })
  end,
})

G.au({ "ColorScheme" }, {
  group = group,
  pattern = "zen*",
  desc = "Override zenbones colorscheme highlights",
  callback = function()
    G.hl_link("PmenuThumb", "PmenuSel")
    G.hl_link("CmpItemAbbr", "CmpItemKindDefault")
    G.hl_update("CmpItemMenu", { italic = true })
  end,
})

local function rshada_after()
  vim.api.nvim_set_option_value("bg", vim.g.BACKGROUND, {})
  if vim.g.COLORSCHEME ~= "" and vim.g.COLORSCHEME ~= vim.g.colors_name then
    local ok, _ = pcall(vim.cmd.colorscheme, vim.g.COLORSCHEME)
    if ok == true then
      vim.api.nvim_exec_autocmds("ColorScheme", { pattern = vim.g.COLORSCHEME })
    end
  end
end

local function wshada_before()
  vim.g.BACKGROUND = vim.api.nvim_get_option_value("bg", {})
  vim.g.COLORSCHEME = vim.g.colors_name
end

G.au({ "VimEnter" }, { group = group, callback = rshada_after })
G.au({ "VimLeavePre" }, { group = group, callback = wshada_before })

-- https://github.com/jdhao/nvim-config/blob/main/lua/config/lsp.lua
G.au({ "LspAttach" }, {
  group = group,
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Temporary until the LSP formatexpr can make comments wrap via `gqq`
    vim.bo[args.buf].formatexpr = nil

    -- Turn off semantic tokens
    client.server_capabilities.semanticTokensProvider = nil

    local method = vim.lsp.protocol.Methods

    if client:supports_method(method.workspace_symbol) then
      G.nmap("<leader>lw", vim.lsp.buf.workspace_symbol, {
        unique = false,
        buffer = args.buf,
        desc = "List workspace symbols",
      })
    end

    if client:supports_method(method.textDocument_typeDefinition) then
      G.nmap("<leader>lt", vim.lsp.buf.type_definition, {
        unique = false,
        buffer = args.buf,
        desc = "List current symbol type definitions",
      })
    end

    if client:supports_method(method.typeHierarchy_subtypes) then
      G.nmap("<leader>lh", function()
        vim.lsp.buf.typehierarchy("subtypes")
      end, {
        unique = false,
        buffer = args.buf,
        desc = "List current symbol type hierarchy",
      })
    end
  end,
})
