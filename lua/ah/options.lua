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

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.smoothscroll = true
vim.opt.grepprg = "rg --vimgrep $*"
vim.opt.exrc = true
vim.opt.showtabline = 1
vim.opt.laststatus = 2
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-TermCursor"
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
-- https://old.reddit.com/r/neovim/comments/1g41rjy/can_neovim_do_this_already_with_treesitter/
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
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
