--[[

https://www.youtube.com/watch?app=desktop&v=Cp0iap9u29c

Highly recommended to run `:options`

# Variables

vim.g
vim.b
vim.b[id]
vim.t
vim.t[id]
vim.w
vim.w[id]

# Options

Options may be

- Local to buffer
- Local to window
- Local to buffer or global (global-local)
- Local to window or global (global-local)

|        Command		       | global value	 | local value | lua equivalent  |
|--------------------------|---------------|-------------|-----------------|
|       :set option=value	 |     set		   |     set     | vim.o / vim.opt |
|  :setlocal option=value	 |      -			   |     set     | vim.opt_local   |
| :setglobal option=value	 |     set		   |      -      | vim.opt_global  |

- vim.o: same as `:set`
- vim.go: same as `:setglobal`

The following options are equivalent to `:setlocal` for global-local options and
`:set` otherwise

## vim.bo, vim.bo[id]

Set buffer options

- If the option is local, behave as `:setlocal`
- If the option is global-local, behave as `:set`

## vim.wo, vim.wo[wid], vim.wo[wid][bnr]

Set window options

- If the option is local, behave as `:setlocal`
- If the option is global-local, behave as `:set`

## vim.opt, vim.opt_local, vim.opt_global

Use these interfaces when manipulating list-style and map-style options

- vim.opt: same as `:set`
- vim.opt_local: same as `:setlocal`
- vim.opt_global: same as `:setglobal`

These have convenient methods on them like `:append`, `:prepent` and `:remove`.
See `:h vim.opt` for more information.

--]]

-- Set by minimax
vim.g.mapleader = " "
vim.o.undofile = true
vim.o.breakindent = true
vim.o.linebreak = true
vim.o.signcolumn = "yes"
vim.o.splitright = true
vim.o.winborder = "single"
vim.o.fillchars =
  "vert:║,horiz:═,horizdown:╦,horizup:╩,verthoriz:╬,vertleft:╣,vertright:╠,msgsep:═"
vim.opt.listchars = {
  tab = "»·",
  trail = ".",
  eol = "¬",
}
vim.o.foldtext = ""
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99
vim.o.foldminlines = 0
vim.o.expandtab = true
vim.o.formatoptions = "rqnloj"
vim.o.ignorecase = true
vim.o.infercase = true
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.tabstop = 2
vim.o.virtualedit = "block"
vim.o.iskeyword = "@,48-57,_,192-255,-"
vim.o.complete = ".,b,kspell"
vim.o.completeopt = "menuone,noselect,fuzzy,nosort"

-- Not set by minimax
vim.g.maplocalleader = "\\"
-- Treat all numbers as unsigned when inc/dec them via C-A and C-X
vim.o.nrformats = "unsigned"
vim.o.smoothscroll = true
vim.o.grepprg = "rg --vimgrep $*"
vim.o.exrc = true
vim.o.showtabline = 1
vim.o.laststatus = 2
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-TermCursor"
vim.opt.cpoptions:append("q")
vim.o.wrapscan = false
vim.o.shiftround = true
vim.o.gdefault = true
vim.o.wildignorecase = true
vim.o.showbreak = "↪ "
vim.o.softtabstop = 2
vim.o.swapfile = false
vim.o.textwidth = 80
vim.opt.matchpairs:append({ "<:>" })
vim.o.conceallevel = 0
vim.opt.diffopt:append({
  "foldcolumn:0",
  "iwhiteall",
  "vertical",
  "algorithm:minimal",
  "linematch:60",
})
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

-- Enable experimental UI intended to replace the message grid in the TUI
require("vim._core.ui2").enable({ enable = true })
