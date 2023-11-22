---@diagnostic disable

local vim = vim
local lush = require("lush")
local hsluv = lush.hsluv
local hsl = lush.hsl

-- stylua: ignore
local p = {
  black   = hsluv(000, 000, 000),
  red     = hsluv(011, 088, 045),
  yellow  = hsluv(070, 100, 022),
  green   = hsluv(133, 093, 036),
  cyan    = hsluv(202, 094, 047),
  blue    = hsluv(256, 099, 046),
  magenta = hsluv(275, 080, 042),
  white   = hsluv(000, 000, 100),
}

vim.g.terminal_color_0 = p.black.hex
vim.g.terminal_color_1 = p.red.hex
vim.g.terminal_color_2 = p.green.hex
vim.g.terminal_color_3 = p.yellow.hex
vim.g.terminal_color_4 = p.blue.hex
vim.g.terminal_color_5 = p.magenta.hex
vim.g.terminal_color_6 = p.cyan.hex
vim.g.terminal_color_7 = p.white.hex
vim.g.terminal_color_8 = p.black.hex
vim.g.terminal_color_9 = p.red.hex
vim.g.terminal_color_10 = p.yellow.hex
vim.g.terminal_color_11 = p.green.hex
vim.g.terminal_color_12 = p.cyan.hex
vim.g.terminal_color_13 = p.blue.hex
vim.g.terminal_color_14 = p.magenta.hex
vim.g.terminal_color_15 = p.white.hex

return lush(function(x)
	local sym = x.sym
  -- stylua: ignore
  return {
    -- Not a highlight group. It's just the only way of exporting the
    -- palette while having :Lushify work on this file.
    Palette { lush = p },

    -- |highlight-groups|
    Normal { fg = p.black.li(5) },
    NormalNC {},
    NormalFloat { bg = p.black.li(92) },
    Cursor { bg = p.red },
    TermCursor { Cursor },
    TermCursorNC { Cursor },
    StatusLine { bg = p.black.li(75), bold = true },
    StatusLineNC { bg = StatusLine.bg.li(50), bold = true },
    WinSeparator { fg = StatusLine.bg, bg = StatusLine.bg },
    TabLineFill { bg = StatusLine.bg },
    TabLine { bg = TabLineFill.bg.li(40) },
    TabLineSel { Normal, bold = true },
    SignColumn { bg = StatusLine.bg.li(70) },
    LineNr { bg = SignColumn.bg, bold = true },
    LineNrAbove { LineNr },
    LineNrBelow { LineNr },
    Folded { fg = p.black.li(40) },
    FoldColumn { Folded },
    CursorLine { bg = p.white.da(5) },
    CursorColumn { CursorLine },
    CursorLineNr { LineNr },
    CursorLineSign { SignColumn },
    CursorLineFold { FoldColumn },
    ColorColumn { SignColumn },
    DiffAdd { bg = p.green.li(96) },
    DiffChange { bg = p.green.li(96) },
    DiffDelete { bg = p.red.li(88) },
    DiffText { bg = p.green.li(90) },
    Pmenu { bg = p.black.li(85) },
    PmenuSel { bg = p.black.li(75) },
    PmenuSbar { bg = p.black.li(85) },
    PmenuThumb { bg = p.black.li(65) },
    Search { bg = hsl("#fff933"), underline = true, sp = p.yellow.li(70) },
    IncSearch { bg = Search.bg.ro(-20).da(20) },
    Substitute { IncSearch },
    SpellBad { fg = p.red, undercurl = true },
    SpellCap { fg = p.yellow, undercurl = true },
    SpellLocal { fg = p.blue, undercurl = true },
    SpellRare { fg = p.cyan, undercurl = true },
    Visual { bg = p.blue.li(70) },
    VisualNOS { Visual },
    WarningMsg { fg = p.yellow },
    ErrorMsg { fg = p.red },
    ModeMsg { bold = true },
    MsgArea {},
    MsgSeparator {},
    MoreMsg { ModeMsg },
    Title { ModeMsg },
    Whitespace { fg = p.black.li(20), bg = p.black.li(90), bold = true },
    NonText { Whitespace },
    EndOfBuffer { fg = p.black.li(30), bold = true },
    SpecialKey { Whitespace },
    WildMenu {},
    Conceal {},
    Directory { fg = p.blue, bold = true },
    MatchParen { reverse = true },
    FloatBorder { fg = p.black.li(40), bg = NormalFloat.bg },
    FloatTitle { fg = Normal.fg, bg = StatusLine.bg.li(10), bold = true },
    FloatBorderTop { FloatBorder, bg = FloatTitle.bg },     -- Non-standard
    FloatBorderBottom { FloatBorder, bg = NormalFloat.bg }, -- Non-standard
    Question {},
    QuickFixLine { fg = Normal.fg, bg = p.white.da(10), bold = true },

    -- |diagnostic-highlights|
    DiagnosticError { fg = p.red },
    DiagnosticWarn { fg = p.yellow },
    DiagnosticInfo { fg = p.blue },
    DiagnosticHint { fg = p.green },
    DiagnosticUnderlineError { sp = p.red, undercurl = true },
    DiagnosticUnderlineWarn { sp = p.red, undercurl = true },
    DiagnosticUnderlineInfo { sp = p.blue, undercurl = true },
    DiagnosticUnderlineHint { sp = p.green, undercurl = true },

    -- Custom groups for the statusline
    User1 { fg = p.black, bg = StatusLine.bg, bold = true },
    User2 { fg = p.red, bg = StatusLine.bg, bold = true },
    User3 { fg = p.yellow, bg = StatusLine.bg, bold = true },
    User4 { fg = p.green, bg = StatusLine.bg, bold = true },
    User5 { fg = p.cyan, bg = StatusLine.bg, bold = true },
    User6 { fg = p.blue, bg = StatusLine.bg, bold = true },
    User7 { fg = p.magenta, bg = StatusLine.bg, bold = true },
    User8 { fg = p.white, bg = StatusLine.bg, bold = true },

    -- |group-name|
    Comment { fg = Normal.fg, bold = true },
    Constant { fg = Normal.fg },

    String { fg = p.green },
    -- Character
    Number { String },
    Boolean { String },
    Float { String },
    Identifier { fg = Normal.fg },
    -- Function
    Statement { fg = Normal.fg },
    -- Conditional
    -- Repeat
    -- Label
    -- Operator
    -- Keyword
    -- Exception
    PreProc { fg = Normal.fg },
    -- Include
    -- Define
    -- Macro
    -- PreCondit
    Type { fg = Normal.fg },
    -- StorageClass
    -- Structure
    -- Typedef
    Special { fg = Normal.fg },
    -- SpecialChar
    -- Tag
    -- Delimiter
    -- SpecialComment
    -- Debug
    Underlined { underline = true, sp = p.magenta },
    Ignore { fg = Normal.fg },
    Error { fg = p.red, bg = p.red.li(80) },
    Todo { bold = true },

    -- Filetypes
    diffRemoved { DiffDelete },
    diffAdded { DiffAdd },
    diffChanged { DiffChange },
    diffLine { fg = p.magenta, bold = true },

    -- Plugins
    TelescopeNormal { NormalFloat },
    TelescopeMatching { fg = p.magenta, underline = true, bold = true },
    TelescopeResultsComment { fg = Comment.fg },

    -- Fugitive
    fugitiveUntrackedHeading { fg = p.magenta.da(20), bold = true },
    fugitiveUntrackedSection { fg = p.red.da(20), italic = true, bold = true },
    fugitiveUntrackedModifier { fg = p.red.da(20), bold = true },

    fugitiveUnstagedHeading { fugitiveUntrackedHeading },
    fugitiveUnstagedSection { fugitiveUntrackedSection },
    fugitiveUnstagedModifier { fugitiveUntrackedModifier },

    fugitiveStagedHeading { fugitiveUntrackedHeading },
    fugitiveStagedSection { fg = p.green, italic = true, bold = true },
    fugitiveStagedModifier { fg = p.green, bold = true },

    -- |treesitter-highlight-groups|
    sym("@label") { fg = p.magenta, bold = true },

    sym("@text.note") { bold = true },
    sym("@text.uri") { fg = p.blue.da(20), underline = true },
    sym("@text.literal") { fg = Comment.fg, bg = Comment.bg },
    sym("@text.reference") { fg = p.magenta, bold = true },

    sym("@tag.javascript") { bold = true },
    sym("@tag.tsx") { sym("@tag.javascript") },
    sym("@type.builtin") { fg = p.red.da(20), bold = true },

    -- |lsp-semantic-highlight|
    sym("@lsp.type.type") { sym("@type.builtin") },
    sym("@lsp.type.builtin") { sym("@type.builtin") },
    sym("@lsp.type.typeParameter") { sym("@type.builtin") },
    sym("@lsp.type.interface") { sym("@type.builtin") },
    sym("@lsp.type.variable") { fg = p.magenta.da(30), bold = true },
    sym("@lsp.type.parameter") { sym("@lsp.type.variable") },
    sym("@lsp.typemod.function.declaration") { sym("@lsp.type.variable") },
    sym("@lsp.typemod.function.local") { sym("@lsp.type.variable") },

    sym('@method_def') { sym("@lsp.type.variable") }
  }
end)
