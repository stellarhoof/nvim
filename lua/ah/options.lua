-- https://www.youtube.com/watch?app=desktop&v=Cp0iap9u29c

-- Highly recommended to run :options

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.smoothscroll = true
vim.opt.grepprg = "rg --vimgrep $*"
vim.opt.exrc = true
vim.opt.showtabline = 1
vim.opt.laststatus = 2
vim.opt.updatetime = 300 -- CursorHold
vim.opt.pumheight = 15
vim.opt.cpoptions = "aABceFs_q"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.wrapscan = false
vim.opt.shiftround = true
vim.opt.startofline = false
vim.opt.shelltemp = false
vim.opt.gdefault = true
vim.opt.wildignorecase = true
vim.opt.listchars = { tab = "»·", trail = ".", eol = "¬" }
vim.opt.showbreak = "↪ "
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.textwidth = 80
vim.opt.expandtab = true
vim.opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
vim.opt.formatoptions = "jcroqlnt"
vim.opt.complete = { ".", "b" }
vim.opt.undofile = true
vim.opt.conceallevel = 0
vim.opt.signcolumn = "yes"
vim.opt.foldtext = "" --
vim.opt.foldmethod = "indent"
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldminlines = 0
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.fillchars = {
	horiz = "─",
	horizup = "┴",
	horizdown = "┬",
	vert = "│",
	vertleft = "┤",
	vertright = "├",
	verthoriz = "┼",
	diff = " ",
}
vim.opt.diffopt = {
	"filler",
	"foldcolumn:0",
	"iwhiteall",
	"vertical",
	"internal",
	"algorithm:minimal",
	"linematch:60",
}
vim.opt.suffixes = {
	".bak",
	"~",
	".o",
	".h",
	".info",
	".swp",
	".obj",
	".bak",
	"~",
	".swp",
	".bbl",
	".info",
	".aux",
	".ind",
	".blg",
	".brf",
	".cb",
	".idx",
	".ilg",
	".inx",
	".out",
	".toc",
	".dvi",
}
vim.opt.wildignore = {
	"*.pdf",
	"*.mp3",
	"*.avi",
	"*.mpg",
	"*.mp4",
	"*.mkv",
	"*.ogg",
	"*.flv",
	"*.png",
	"*.jpg",
	"*.pyc",
	"*.o",
	"*.obj",
	"*.deb",
	"*.ico",
	"*.mov",
	"*.swf",
	"*.class",
	"*.elc",
	"*.native",
	"*.rbc",
	"*.rbo",
	".svn",
	"*.gem",
	"._*",
	".DS_Store",
	"*.dmg",
	".git/",
	".localized",
}
