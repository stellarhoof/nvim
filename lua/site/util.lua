local M = {}

M.fpcall = function (f)
  local ok, err = xpcall(f, function (e) return debug.traceback(e .. "\n", 2) end)
  if not ok then
    vim.notify("Error during safe execution: " .. err, vim.log.levels.WARN)
    return false
  end
  return true
end

return M
