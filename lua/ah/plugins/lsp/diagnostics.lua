local M = {}

M.signs = { Error = " ", Warn = " ", Info = " ", Hint = " " }

M.severity = { min = vim.diagnostic.severity.WARN }

function M.setup()
	vim.diagnostic.config({
		underline = { severity = M.severity },
		virtual_text = false,
		signs = false,
		update_in_insert = false,
		float = { source = true, header = "", title = "Diagnostics" },
	})

	vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
		local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
		pcall(vim.diagnostic.reset, ns)
		return true
	end

	-- |diagnostic-signs|
	for type, icon in pairs(M.signs) do
		local hl = "DiagnosticSign" .. type
		fn.sign_define(hl, { text = icon, texthl = hl, numhl = "", linehl = "" })
	end
end

return M
