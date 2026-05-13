--[[
# Welcome to MiniMax

This is a config designed to mostly use MINI. It provides out of the box
a stable, polished, and feature rich Neovim experience. Its structure:

├ init.lua          Initial (this) file executed during startup
├ plugin/           Files automatically sourced during startup
├── 10_options.lua  Built-in Neovim behavior
├── 20_keymaps.lua  Custom mappings
├── 30_mini.lua     MINI configuration
├── 40_plugins.lua  Plugins outside of MINI
├ snippets/         User defined snippets (has demo file)
├ after/            Files to override behavior added by plugins
├── ftplugin/       Files for filetype behavior (has demo file)
├── lsp/            Language server configurations (has demo file)
├── snippets/       Higher priority snippet files (has demo file)

Config files are meant to be read, preferably inside a Neovim instance running
this config and opened at its root. This will help you better understand your
setup. Start with this file. Any order is possible, prefer the one listed above.
Ways of navigating your config:
- `<Space>` + `e` + (one of) `iokmp` - edit 'init.lua' or 'plugin/' files.
- Inside config directory: `<Space>ff` (picker) or `<Space>ed` (explorer)
- Navigate existing buffers with `[b`, `]b`, or `<Space>fb`.

Config files are also meant to be customized. Initially it is a baseline of
a working config based on MINI. Modify it to make it yours. Some approaches:
- Modify already existing files in a way that keeps them consistent.
- Add new files in a way that keeps config consistent.
  Usually inside 'plugin/' or 'after/'.

Documentation comments like this can be found throughout the config.
Common conventions:

- See `:h key-notation` for key notation used.
- `:h xxx` means "documentation of helptag xxx". Either type text directly
  followed by Enter or type `<Space>fh` to open a helptag fuzzy picker.
- "Type `<Space>fh`" means "press <Space>, followed by f, followed by h".
  Unless said otherwise, it assumes that Normal mode is current.
- "See 'path/to/file'" means see open file at described path and read it.
- `:SomeCommand ...` or `:lua ...` means execute mentioned command.

# Plugin manager

This config uses `vim.pack` - built-in plugin manager. Its main entry
point is a `vim.pack.add()` function, which acts like a "smarter `:packadd`":
load plugin after making sure it is installed from source. The state of
installed plugins is recorded in the lockfile named 'nvim-pack-lock.json'.
Example usage:
- `vim.pack.add({ ... })` - use inside config to add one or more plugins.
- `:lua vim.pack.update()` - update all plugins; execute `:write` to confirm.
- `:lua vim.pack.del({ ... })` - delete specific plugins.

See also:
- `:h vim.pack-examples` - how to use it
- `:h vim.pack-lockfile` - lockfile info
- `:h vim.pack-events` - available events and plugin hooks examples
- `:h vim.pack.update()` - more details about confirmation step
--]]

-- Global utils

_G.G = {}

-- 'mini.nvim' - all-in-one plugin powering most MiniMax features.
-- Load now to have 'mini.misc' available for custom loading helpers.
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

G.misc = require("mini.misc")

function G.buf_cwd()
  return vim.b.dir or vim.fn.getcwd()
end

local function mapmode(mode)
  return function(lhs, rhs, opts)
    opts = opts or {}
    vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend("force", { unique = false }, opts or {}))
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
