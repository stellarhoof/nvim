-- Sets the leader key, which can be used in mappings via <leader>
vim.g.mapleader = " "

-- Sets the local leader key, which can be used in mappings via <localleader>
vim.g.maplocalleader = "\\"

-- Automatically save undo history to file.
vim.o.undofile = true

-- Enables project-local configuration via `.nvim.lua`, `.nvimrc`, or `.exrc` files.
vim.o.exrc = true

-- Vertical splits show to the right by default.
vim.o.splitright = true

-- One scroll event always scrolls one line even if wrapped.
vim.o.smoothscroll = true

-- Do not wrap searches after first/last match.
vim.o.wrapscan = false

-- Filter quickfix list.
vim.cmd.packadd("cfilter")

-- Visualize neovim startuptime information.
vim.pack.add({ "https://github.com/seblyng/nvim-startuptime" }, { confirm = false })

-- Define command line mode aliases.
vim.pack.add({ "https://github.com/konfekt/vim-alias" }, { confirm = false })
vim.cmd.Alias({ args = { "w", "up" }, bang = true })

-- mini.nvim is used all throughout this config so add it early on.
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" }, { confirm = false })
_G.now = function (f)
  require("mini.misc").safely("now", f)
end
_G.later = function (f)
  require("mini.misc").safely("later", f)
end

vim.keymap.set({ "n" }, "<c-s>", vim.cmd.wall, {
  desc = "Write all buffers",
})

vim.keymap.set({ "n" }, "gK", vim.show_pos, {
  desc = "Show items at a given buffer position.",
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Highlight yanked text",
  callback = function ()
    vim.hl.hl_op({ timeout = 200 })
  end,
})

-- Also see |++p|
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
  desc = "Create missing directories when saving a file",
  callback = function (event)
    if not event.match:match("^%w%w+://") then
      local file = vim.uv.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  desc = "Go to last location when opening a buffer",
  callback = function (event)
    local ignore_buftype = { "quickfix", "nofile", "help" }
    local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }
    local buf = event.buf
    if vim.tbl_contains(ignore_buftype, vim.bo[buf].buftype) or vim.tbl_contains(
        ignore_filetype, vim.bo[buf].filetype
      ) or vim.b[buf].last_loc then
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
