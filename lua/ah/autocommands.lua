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

au({ "ColorScheme" }, {
	group = group,
	desc = "Override general colorscheme highlights",
	callback = function()
		hl_clear("Folded")
		hl_link("FloatBorder", "NormalFloat")
		hl_link("FloatTitle", "NormalFloat", { bold = true })
		hl_update("Directory", { bold = true })
		hl_update("DiagnosticUnderlineHint", { undercurl = true })
		hl_update("DiagnosticUnderlineInfo", { undercurl = true })
		hl_update("DiagnosticUnderlineWarn", { undercurl = true })
		hl_update("DiagnosticUnderlineError", { undercurl = true })
	end,
})

au({ "ColorScheme" }, {
	group = group,
	pattern = "zen*",
	desc = "Override zenbones colorscheme highlights",
	callback = function()
		hl_link("PmenuThumb", "PmenuSel")
		hl_link("CmpItemAbbr", "CmpItemKindDefault")
		hl_update("CmpItemMenu", { italic = true })
		hl_update("WinSeparator", { bg = hl_get("NormalNC").bg })
	end,
})

local function rshada_after()
	vim.api.nvim_set_option_value("bg", vim.g.BACKGROUND, {})
	if vim.g.COLORSCHEME ~= "" and vim.g.COLORSCHEME ~= vim.g.colors_name then
		vim.cmd.colorscheme(vim.g.COLORSCHEME)
		vim.api.nvim_exec_autocmds("ColorScheme", { pattern = vim.g.COLORSCHEME })
	end
end

local function rshada()
	vim.defer_fn(function()
		vim.cmd.rshada()
		rshada_after()
	end, 100)
end

local function wshada_before()
	vim.g.BACKGROUND = vim.api.nvim_get_option_value("bg", {})
	vim.g.COLORSCHEME = vim.g.colors_name
end

local function wshada()
	wshada_before()
	vim.cmd.wshada()
end

au({ "VimEnter" }, { group = group, callback = rshada_after })
-- au({ "FocusGained" }, { group = group, callback = rshada })
au({ "VimLeavePre" }, { group = group, callback = wshada_before })
-- au({ "FocusLost" }, { group = group, callback = wshada })
