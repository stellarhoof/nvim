-- Highly recommended to run :options

local opt = vim.opt

-- Not a vim option
vim.g.grepprg = {
  "rg",
  "--color=never",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case",
  "--hidden",
  "--glob=!.git",
  "--glob=!.yarn/*",
  "--glob=!flake.lock",
  "--glob=!yarn.lock",
  "--glob=!package-lock.json",
}
opt.grepprg = table.concat(vim.g.grepprg, " ")
opt.grepformat = { "%f:%l:%c:%m", "%f:%l:%m" }
opt.exrc = true
opt.showtabline = 1
opt.statusline = "%!v:lua.require'ah.statusline'(win_getid())"
opt.laststatus = 2
opt.updatetime = 300 -- CursorHold
opt.pumheight = 25
opt.cpoptions = "aABceFs_q"
opt.smartcase = true
opt.ignorecase = true
opt.wrapscan = false
opt.shiftround = true
opt.diffopt = {
  "filler",
  "foldcolumn:0",
  "iwhiteall",
  "vertical",
  "internal",
  "algorithm:minimal",
  "linematch:60",
}
opt.startofline = false
opt.shelltemp = false
opt.gdefault = true
opt.wildignorecase = true
opt.wildignore = {
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
opt.suffixes = {
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
vim.opt.shortmess:append({ I = true })
vim.opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
  diff = " ",
}
opt.listchars = { tab = "»·", trail = ".", eol = "¬" }
opt.showbreak = "↪ "
opt.termguicolors = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.swapfile = false
opt.textwidth = 80
opt.expandtab = true
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.formatoptions = "jcroql"
opt.complete = ".,b,t"
opt.undofile = true
opt.conceallevel = 0
opt.signcolumn = "no"
opt.foldlevel = 99
opt.foldminlines = 0
opt.linebreak = true
opt.breakindent = true
vim.wo.foldmethod = "indent"
