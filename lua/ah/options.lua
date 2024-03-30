-- https://www.youtube.com/watch?app=desktop&v=Cp0iap9u29c

-- Highly recommended to run :options

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
  "--glob=!e2e",
  "--glob=!.git",
  "--glob=!.yarn/*",
  "--glob=!flake.lock",
  "--glob=!yarn.lock",
  "--glob=!package-lock.json",
}

vim.opt.bg = "light"
vim.opt.foldmethod = "indent"
vim.opt.grepprg = table.concat(vim.g.grepprg, " ")
vim.opt.grepformat = { "%f:%l:%c:%m", "%f:%l:%m" }
vim.opt.exrc = true
vim.opt.showtabline = 1
vim.opt.laststatus = 2
vim.opt.updatetime = 300 -- CursorHold
vim.opt.pumheight = 25
vim.opt.cpoptions = "aABceFs_q"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.wrapscan = false
vim.opt.shiftround = true
vim.opt.startofline = false
vim.opt.shelltemp = false
vim.opt.gdefault = true
vim.opt.wildignorecase = true
vim.opt.shortmess:append({ I = true })
vim.opt.listchars = { tab = "»·", trail = ".", eol = "¬" }
vim.opt.showbreak = "↪ "
vim.opt.termguicolors = true
vim.opt.splitkeep = "screen"
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
vim.opt.foldlevel = 99
vim.opt.foldminlines = 0
vim.opt.linebreak = true
vim.opt.breakindent = true
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
