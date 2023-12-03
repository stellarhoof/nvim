local has_devicons, devicons = pcall(require, "nvim-web-devicons")

local function safe_concat(tbl, sep)
	return table.concat(
		vim.tbl_filter(function(x)
			return x ~= nil
		end, tbl),
		sep
	)
end

local function git_branch(buf)
	local head = vim.fn.FugitiveHead(6, buf.bufnr)
	if #head > 0 then
		return " " .. head
	end
end

local function buf_icon(buf)
	local icon = devicons.get_icon(vim.fn.fnamemodify(buf.name, ":e"))
	return icon and icon .. "  " or ""
end

local function diagnostics_section(bufnr)
	return function(severity)
		local count = #vim.diagnostic.get(
			bufnr,
			{ severity = vim.diagnostic.severity[vim.fn.toupper(severity)] }
		)
		if count > 0 then
			return string.format(
				"%%#DiagnosticStatus%s#%s%i%%*",
				severity,
				require("ah.plugins.lsp.diagnostics").signs[severity],
				count
			)
		end
	end
end

local sections = {
	" ",
	git_branch,
	"%=",
	function(buf)
		return vim.fn.fnamemodify(buf.name, ":~:.")
	end,
	" ",
	function(buf)
		return vim.tbl_map(diagnostics_section(buf.bufnr), { "Warn", "Error" })
	end,
	"%=",
	"%3l:%-2v",
	"%3p%%",
}

return function(current_winid)
	local is_active = vim.g.statusline_winid == current_winid
	local buffer = vim.fn.getbufinfo(vim.api.nvim_win_get_buf(vim.g.statusline_winid))[1]

	local statusline = ""

	for _, section in pairs(sections) do
		if type(section) == "table" then
			local active, inactive = unpack(section)
			section = is_active and active or inactive
		elseif type(section) == "function" then
			section = section(buffer, is_active)
		end
		if type(section) == "table" then
			section = safe_concat(section, " ")
		end
		statusline = statusline .. (section or "")
	end

	return statusline
end
