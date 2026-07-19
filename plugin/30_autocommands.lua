vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Highlight yanked text",
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
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

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Create missing directories when saving a file",
  callback = function(event)
    if not event.match:match("^%w%w+://") then
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end
  end,
})
