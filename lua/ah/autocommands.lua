local group = aug("init", {})

-- https://github.com/neovim/neovim/issues/1936
au({ "FocusGained", "TermClose", "TermLeave" }, {
	group = group,
	desc = "Autoread current file",
	command = "checktime",
})

-- :h lua-highlight
au({ "TextYankPost" }, {
	group = group,
	desc = "Highlight yanked text",
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

au({ "BufReadPost" }, {
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

au({ "BufWritePre" }, {
	group = group,
	desc = "Create missing directories when saving a file",
	callback = function(event)
		if not event.match:match("^%w%w+://") then
			local file = vim.loop.fs_realpath(event.match) or event.match
			vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
		end
	end,
})

au({ "OptionSet" }, {
	group = group,
	desc = "Persist options for ShaDa",
	callback = function(event)
		if event.match == "background" then
			vim.api.nvim_set_var(string.upper(event.match), vim.v.option_new)
		end
	end,
})

au({ "ColorScheme" }, {
	group = group,
	desc = "Override colorscheme highlights",
	callback = function()
		vim.cmd([[
      hi Directory gui=bold
      hi DiagnosticUnderlineHint gui=undercurl
      hi DiagnosticUnderlineInfo gui=undercurl
      hi DiagnosticUnderlineWarn gui=undercurl
      hi DiagnosticUnderlineError gui=undercurl
    ]])
	end,
})

au({ "ColorScheme" }, {
	group = group,
	desc = "Persist colorscheme name for ShaDa",
	callback = function(event)
		vim.g.COLORSCHEME = event.match
	end,
})

au({ "VimEnter" }, {
	group = group,
	desc = "Restore last colorscheme and background",
	callback = function()
		if vim.g.BACKGROUND then
			vim.opt.bg = vim.g.BACKGROUND
		end
		if vim.g.COLORSCHEME then
			vim.cmd.colorscheme(vim.g.COLORSCHEME)
			vim.api.nvim_exec_autocmds("ColorScheme", { pattern = vim.g.COLORSCHEME })
		end
	end,
})
