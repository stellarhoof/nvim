local M = {}

-- Copied from $VIMRUNTIME/lua/vim/_defaults.lua
function M.open_uri(uri)
	if not uri or uri == "" then
		return "empty uri"
	end
	local cmd, err = vim.ui.open(uri)
	local rv = cmd and cmd:wait(1000) or nil
	if cmd and rv and rv.code ~= 0 then
		err = ("vim.ui.open: command %s (%d): %s"):format(
			(rv.code == 124 and "timeout" or "failed"),
			rv.code,
			vim.inspect(cmd.cmd)
		)
	end
	if err then
		return err
	end
end

return M
