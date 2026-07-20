--[[
Run `:options` for an interactive list of all current options.

Options values can be one if the following types:
- global         : Global only.
- global-local   : Global but can be overridden per buffer/window.
- local          : Per buffer/window; has mutable global defaults that are copied from upon creating new buffers/windows.
- local-noglobal : Per buffer/window; does not have mutable global defaults.

- Window local values are remembered for each buffer.

Lua interface for options (see `:h lua-options`)

- `vim.o`         : gets or sets options (like `:set`)
- `vim.go`        : gets or sets global options (like `:setglobal`)
- `vim.bo`        : gets or sets buffer local options (like `:setlocal`)
- `vim.wo`        : gets or sets window local options (like `:setlocal`)
- `vim.opt`       : gets or sets list/map style options (like `:set`)
- `vim.opt_local` : gets or sets list/map style options (like `:setlocal`)
- `vim.opt_global`: gets or sets list/map style options (like `:setglobal`)
--]]

-- General ======================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.undofile = true
vim.o.grepprg = "rg --vimgrep $*"
vim.o.exrc = true
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

-- UI ===========================================================================

vim.o.breakindent = true
vim.o.conceallevel = 0
vim.o.laststatus = 2
vim.o.showbreak = "↪ "
vim.o.showtabline = 1
vim.o.signcolumn = "yes"
vim.o.smoothscroll = true
vim.o.splitright = true
vim.o.winborder = "single"
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-TermCursor"
vim.opt.fillchars = {
  diff = " ",
  vert = "║",
  horiz = "═",
  horizdown = "╦",
  horizup = "╩",
  verthoriz = "╬",
  vertleft = "╣",
  vertright = "╠",
  msgsep = "═",
}
vim.opt.listchars = {
  tab = "»·",
  trail = ".",
  eol = "¬",
}

-- UI (folding) ====================================================================

vim.o.foldtext = ""
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99
vim.o.foldminlines = 0

-- Editing =========================================================================

vim.o.expandtab = true
vim.o.formatoptions = "rqnloj"
vim.o.gdefault = true
vim.o.ignorecase = true
vim.o.infercase = true
vim.o.iskeyword = "@,48-57,_,192-255,-"
vim.o.nrformats = "unsigned" -- Treat all numbers as unsigned when inc/dec them via C-A and C-X
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.softtabstop = 2
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.textwidth = 80
vim.o.virtualedit = "block"
vim.o.wildignorecase = true
vim.o.wrapscan = false
vim.opt.matchpairs:append({ "<:>" })
vim.opt.cpoptions:append("q")
vim.opt.diffopt:append({
  "foldcolumn:0",
  "iwhiteall",
  "vertical",
  "algorithm:patience",
  "linematch:60",
  "inline:char",
})

-- Completion =========================================================================

vim.opt.completeopt = { "menuone", "noselect", "fuzzy" }
