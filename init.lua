au = vim.api.nvim_create_autocmd
aug = vim.api.nvim_create_augroup
root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")
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

require("ah.options")
require("ah.keymaps")
require("ah.autocommands")
require("ah.lazy")
