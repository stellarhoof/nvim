-- Ships with lush
local to_lua = require("shipwright.transform.lush").to_lua

local template = [[
cmd.highlight("clear")
vim.g.colors_name = "%name"
hl({
  %s
})
]]

return function(name)
  package.loaded["ah.plugins.lush.specs." .. name] = nil
  local spec = require("ah.plugins.lush.specs." .. name)

  local text = string.gsub(
    string.gsub(template, "%%name", name),
    "%%s",
    table.concat(to_lua(spec), "\n\t")
  )

  -- Open file for writing
  local fd, e = io.open(os.getenv('XDG_CONFIG_HOME') .. "/nvim/colors/" .. name .. ".lua", "w")
  assert(fd, e)

  -- Write text
  fd:write(text)

  -- Close file handle
  fd:close()
end
