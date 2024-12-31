-- https://github.com/roginfarrer/fzf-lua-lazy.nvim

-- https://github.com/piersolenski/telescope-import.nvim
-- Could we use https://ast-grep.github.io/ for locating imports?

-- https://github.com/2KAbhishek/nerdy.nvim
-- Really simple to replicate.
-- Use https://github.com/8bitmcu/NerdFont-Cheat-Sheet

-- Repos:
-- Combination of projects + lazy.nvim plugins list

local borders = {
  -- { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
  full = { "🬕", "▔", "🬨", "▐", "🬷", "▁", "🬲", "▌" },
  top = { "▔", "▔", "▔", "", "", " ", " ", " " },
}

return {
  "https://github.com/ibhagwan/fzf-lua",
  config = function()
    local fzf = require("fzf-lua")
    local actions = require("fzf-lua.actions")

    fzf.setup({
      fzf_colors = true,
      file_icon_padding = " ",
      defaults = {
        file_icons = "mini",
        git_icons = false,
        color_icons = false,
      },
      hls = {
        border = "Special",
        preview_border = "Special",
        help_border = "Special",
      },
      winopts = {
        width = 90,
        height = 20,
        border = borders.full,
        preview = {
          title = false,
          hidden = "hidden",
          border = "noborder", -- Only for native fzf previewers
          scrollbar = false,
        },
      },
      -- [FZF options](https://junegunn.github.io/fzf/reference/)
      fzf_opts = {
        ["--pointer"] = " ",
        ["--marker"] = "▎",
        ["--padding"] = "0,2",
        ["--ellipsis"] = " ",
        ["--no-separator"] = true,
        ["--no-scrollbar"] = true,
      },
      keymap = {
        builtin = {
          ["<c-/>"] = "toggle-help",
          ["<alt-2>"] = "toggle-fullscreen",
          ["<alt-3>"] = "toggle-preview-wrap",
          ["<alt-4>"] = "toggle-preview",
          ["<alt-5>"] = "toggle-preview-ccw", -- Rotate preview counter-clockwise
          ["<alt-6>"] = "toggle-preview-cw", -- Rotate preview clockwise
          ["<alt-up>"] = "preview-page-up",
          ["<alt-down>"] = "preview-page-down",
        },
        -- fzf '--bind=' options
        fzf = {
          ["ctrl-q"] = false,
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          ["alt-g"] = "first",
          ["alt-G"] = "last",
          ["alt-3"] = "toggle-preview-wrap",
          ["alt-4"] = "toggle-preview",
          ["alt-up"] = "preview-page-up",
          ["alt-down"] = "preview-page-down",
        },
      },
      actions = {
        files = {
          true,
          ["alt-Q"] = false,
          ["enter"] = actions.file_edit,
          ["alt-l"] = actions.file_sel_to_ll,
        },
      },
      help_open_win = function(buf, enter, opts)
        opts.border = borders.top
        return vim.api.nvim_open_win(buf, enter, opts)
      end,
      files = {
        prompt = "Files> ",
        cwd_header = true,
        cwd_prompt = false,
      },
      helptags = {
        previewer = "help_native",
      },
    })

    G.nmap("<leader>p", fzf.builtin, { noremap = true, desc = "Pickers" })

    G.nmap("<leader>f", function()
      fzf.files({ cwd = G.buf_cwd() })
    end, { noremap = true, desc = "Files" })

    G.nmap("<leader>o", fzf.oldfiles, { noremap = true, desc = "Old Files" })

    G.nmap("<leader>h", fzf.helptags, { noremap = true, desc = "Help Tags" })

    G.nmap("<leader>b", fzf.buffers, { noremap = true, desc = "Buffers" })

    G.nmap("<leader>s", function()
      fzf.live_grep({ cwd = G.buf_cwd() })
    end, { noremap = true, desc = "Live Grep" })

    G.nmap("<leader>g", fzf.live_grep, { noremap = true, desc = "Git branches" })
  end,
}
