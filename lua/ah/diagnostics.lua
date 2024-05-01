vim.diagnostic.config({
	virtual_text = false,
	float = { source = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
})

nmap("<leader>dd", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "Toggle diagnostics for current buffer" })

nmap("<leader>di", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
nmap(
	"<leader>dl",
	vim.diagnostic.setloclist,
	{ desc = "Add current buffer diagnostics to loclist" }
)
nmap(
	"<leader>dq",
	vim.diagnostic.setqflist,
	{ desc = "Add all buffers diagnostics to quickfix list" }
)

local severity = { min = vim.diagnostic.severity.HINT }

nmap("[d", function()
	vim.diagnostic.goto_prev({
		severity = severity,
		float = false,
		wrap = false,
	})
end, { desc = "Go to previous diagnostic" })

nmap("[D", function()
	vim.diagnostic.goto_next({
		severity = severity,
		float = false,
		cursor_position = { 0, 0 },
	})
end, { desc = "Go to first diagnostic" })

nmap("]d", function()
	vim.diagnostic.goto_next({
		severity = severity,
		float = false,
		wrap = false,
	})
end, { desc = "Go to next diagnostic" })

nmap("]D", function()
	vim.diagnostic.goto_next({
		severity = severity,
		float = false,
		cursor_position = { -1, -1 },
	})
end, { desc = "Go to last diagnostic" })
