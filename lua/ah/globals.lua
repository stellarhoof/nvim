-- Global utils

G = {}

function G.buf_cwd()
  return vim.b.dir or vim.fn.getcwd()
end

function G.merge(...)
  return vim.tbl_deep_extend("force", ...)
end

-- autocmd aliases
G.au = vim.api.nvim_create_autocmd
G.aug = vim.api.nvim_create_augroup

local function mapmode(mode)
  return function(lhs, rhs, opts)
    opts = opts or {}
    vim.keymap.set(mode, lhs, rhs, G.merge({ unique = not opts.buffer }, opts or {}))
  end
end

-- keymaps aliases
G.map = vim.keymap.set
G.unmap = vim.keymap.del
G.nmap = mapmode("n")
G.imap = mapmode("i")
G.vmap = mapmode("v")
G.cmap = mapmode("c")
G.omap = mapmode("o")
G.xmap = mapmode("x")

function G.hl_get(name)
  return vim.api.nvim_get_hl(0, { name = name })
end

function G.hl_set(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

function G.hl_link(name, link, opts)
  if opts == nil then
    G.hl_set(name, { link = link })
  else
    G.hl_set(name, G.merge(G.hl_get(link), opts))
  end
end

function G.hl_clear(name)
  G.hl_set(name, {})
end

function G.hl_update(name, opts)
  G.hl_set(name, G.merge(G.hl_get(name), opts))
end

function G.command(name, cmd, opts)
  if opts.alias ~= nil and G.is_plugin_loaded("vim-alias") then
    vim.cmd.Alias({ args = { opts.alias, name } })
    opts.alias = nil
    vim.api.nvim_create_user_command(name, cmd, opts)
  end
  vim.api.nvim_create_user_command(name, cmd, opts)
end

function G.is_plugin_loaded(name)
  local plugin = require("lazy.core.config").plugins[name]
  if plugin then
    return plugin._.loaded
  end
  return false
end

return G
