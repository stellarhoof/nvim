-- TODO: Copy some of the tweaks in zenbones to the default colorscheme
-- TODO: Check https://github.com/kyzabuilds/xeno.nvim
local config = {
  darkness = "stark",
  lightness = "dim",
  darken_noncurrent_window = true,
  solid_vert_split = true,
  italic_comments = false,
  italic_strings = false,
}
vim.g.zenbones = config
vim.g.zenwritten = config
vim.g.defaultbones = config

vim.pack.add({
  "https://github.com/rktjmp/lush.nvim",
  "https://github.com/zenbones-theme/zenbones.nvim",
}, { confirm = false })

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  desc = "Override zenbones colorscheme highlights",
  pattern = { "zen*" },
  callback = function ()
    vim.api.nvim_set_hl(0, "Folded", { link = "StatusLineNC" })
  end,
})

-- Default colors: https://github.com/nshern/neovim-default-colorscheme-extras
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  desc = "Default colorscheme tweaks",
  pattern = "default",
  -- See |syntax| for a list of nvim colors.
  callback = function ()
    vim.api.nvim_set_hl(0, "Folded", {})
    vim.api.nvim_set_hl(0, "Type", { update = true, fg = "NvimDarkYellow" })
    vim.api.nvim_set_hl(0, "Directory", { update = true, bold = true })

    -- Diff
    -- TODO: Apply this highlight only for diff windows.
    vim.api.nvim_set_hl(0, "DiffChange", {})

    -- Diagnostics
    vim.api.nvim_set_hl(
      0, "DiagnosticUnderlineError", { update = true, undercurl = true }
    )
    vim.api.nvim_set_hl(
      0, "DiagnosticUnderlineWarn", { update = true, undercurl = true }
    )
    vim.api.nvim_set_hl(
      0, "DiagnosticUnderlineInfo", { update = true, undercurl = true }
    )
    vim.api.nvim_set_hl(
      0, "DiagnosticUnderlineHint", { update = true, undercurl = true }
    )
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { update = true, undercurl = true })

    -- TSX
    vim.api.nvim_set_hl(0, "@type.builtin.typescript", { link = "Type" })
    vim.api.nvim_set_hl(0, "@type.builtin.tsx", { link = "@type.builtin.typescript" })
  end,
})

vim.cmd.colorscheme("zenbones")
-- vim.cmd.colorscheme("zenwritten")
-- vim.cmd.colorscheme("default")
