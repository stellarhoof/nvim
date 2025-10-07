-- Global utils

G = {}

function G.buf_cwd()
  return vim.b.dir or vim.fn.getcwd()
end

local function mapmode(mode)
  return function(lhs, rhs, opts)
    opts = opts or {}
    vim.keymap.set(
      mode,
      lhs,
      rhs,
      vim.tbl_deep_extend("force", { unique = not opts.buffer }, opts or {})
    )
  end
end

-- keymaps aliases
G.map = vim.keymap.set
G.unmap = vim.keymap.del
G.nmap = mapmode("n")
G.imap = mapmode("i")
G.tmap = mapmode("t")
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
    G.hl_set(name, vim.tbl_deep_extend("force", G.hl_get(link), opts))
  end
end

function G.hl_clear(name)
  G.hl_set(name, {})
end

function G.hl_update(name, opts)
  G.hl_set(name, vim.tbl_deep_extend("force", G.hl_get(name), opts))
end

return G
