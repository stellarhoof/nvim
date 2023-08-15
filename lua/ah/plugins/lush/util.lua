local M = {}

local fns = {}

M.write_file = function(path, text)
	local fd, e = io.open(path, "w")
	assert(fd, e)
	fd:write(text)
	fd:close()
end

M.with_spec = function(fn)
	table.insert(fns, fn)
end

M.use_specs = function()
	local success, lush = pcall(require, "lush")
	local final = nil
	if success then
		final = lush(function()
			return {}
		end)
		for i = 1, #fns do
			local result = fns[i](final)
			if result then
				final = lush.merge({ final, result })
			end
		end
		lush(final)
	end
	fns = {}
	return final
end

return M
