-- Global utils

function buf_cwd()
	return vim.b.dir or vim.fn.getcwd()
end

function merge(...)
	return vim.tbl_deep_extend("force", ...)
end

-- This directory
root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")

-- autocmd aliases
au = vim.api.nvim_create_autocmd
aug = vim.api.nvim_create_augroup

local function mapmode(mode)
	return function(lhs, rhs, opts)
		vim.keymap.set(mode, lhs, rhs, merge({ unique = true }, opts or {}))
	end
end

-- keymaps aliases
map = vim.keymap.set
unmap = vim.keymap.del
nmap = mapmode("n")
imap = mapmode("i")
vmap = mapmode("v")
cmap = mapmode("c")
omap = mapmode("o")
xmap = mapmode("x")

function hl_get(name)
	return vim.api.nvim_get_hl(0, { name = name })
end

function hl_set(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

function hl_link(name, link, opts)
	if opts == nil then
		hl_set(name, { link = link })
	else
		hl_set(name, merge(hl_get(link), opts))
	end
end

function hl_clear(name)
	hl_set(name, {})
end

function hl_update(name, opts)
	hl_set(name, merge(hl_get(name), opts))
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

require("lazy").setup("ah.plugins", {
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
