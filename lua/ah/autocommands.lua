local group = aug("init", {})

-- https://github.com/neovim/neovim/issues/1936
au({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Autoread current file",
  group = group,
  command = "checktime",
})

-- :h lua-highlight
au({ "TextYankPost" }, {
  desc = "Highlight yanked text",
  group = group,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

au({ "BufReadPost" }, {
  desc = "Go to last location when opening a buffer",
  group = group,
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

au({ "BufWritePre" }, {
  desc = "Create missing directories when saving a file",
  group = group,
  callback = function(event)
    if not event.match:match("^%w%w+://") then
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end
  end,
})
