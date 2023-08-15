local M = {}

-- Pretty print lua value
M.dump = function(...)
  print(vim.inspect(...))
end

-- Ex: hl({ Group = { fg = "white" } })
M.hl = function(groups)
  for group, attrs in pairs(groups) do
    local normalized = {}
    for attr, def in pairs(attrs) do
      normalized[attr] = type(def) == "boolean" and def or tostring(def)
    end
    api.nvim_set_hl(0, group, normalized)
  end
end

local root_cache = {}

M.buf_root_dir = function(bufnum, markers)
  local path = api.nvim_buf_get_name(0)
  local listed = api.nvim_buf_get_option(0, "buflisted")
  if listed == true and path ~= "" then
    local dir = vim.fs.dirname(path)
    local root = root_cache[dir]
    if root == nil then
      local root_file = vim.fs.find(markers, { path = dir, upward = true })[1]
      if root_file ~= nil then
        root = vim.fs.dirname(root_file)
        root_cache[dir] = root
      end
    end
    return root
  end
end

return M
