-- Some global utils
fn = vim.fn
api = vim.api
au = vim.api.nvim_create_autocmd
aug = vim.api.nvim_create_augroup
cmd = vim.cmd
map = vim.keymap.set
nmap = function(...)
  vim.keymap.set("n", ...)
end
imap = function(...)
  vim.keymap.set("i", ...)
end
vmap = function(...)
  vim.keymap.set("v", ...)
end
cmap = function(...)
  vim.keymap.set("c", ...)
end
omap = function(...)
  vim.keymap.set("o", ...)
end
xmap = function(...)
  vim.keymap.set("x", ...)
end

-- This directory
root = fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")

local group = aug("init", {})

au("FocusGained", {
  desc = "Autoread current file (https://github.com/neovim/neovim/issues/1936)",
  group = group,
  command = "checktime",
})

au("TextYankPost", {
  desc = "Highlight yanked text (:h lua-highlight)",
  group = group,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

for k, v in pairs(require("ah.util")) do
  _G[k] = v
end

require("ah.options")
require("ah.mappings")
require("ah.lazy")

-- Change colorschemes if running inside linux framebuffer
if os.getenv("TERM") == "linux" then
  cmd.colorscheme("pablo")
elseif os.getenv("TERM") == "xterm-kitty" then
  cmd.colorscheme("furnisher")
else
  cmd.colorscheme("tokyonight-night")
end
