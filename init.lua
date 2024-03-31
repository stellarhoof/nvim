au = vim.api.nvim_create_autocmd
aug = vim.api.nvim_create_augroup
root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")
map = vim.keymap.set
unmap = vim.keymap.del
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

require("lazy").setup("ah.plugins", {
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
