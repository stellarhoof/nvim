-- Global utils

G = {}

function G.buf_cwd()
  return vim.b.dir or vim.fn.getcwd()
end

function G.merge(...)
  return vim.tbl_deep_extend("force", ...)
end

-- This directory
G.root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")

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
  return require("lazy.core.config").plugins[name]._.loaded
end

require("ah.options")
require("ah.keymaps")
require("ah.autocommands")
require("ah.diagnostics")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  spec = "ah.plugins",
  defaults = {
    cond = function(p)
      return true
      -- local load = {
      --   "nvim-treesitter",
      --   "lua-utils.nvim",
      --   "pathlib.nvim",
      --   "nvim-nio",
      --   "neorg",
      -- }
      -- return vim.tbl_contains(load, p.name)
    end,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
