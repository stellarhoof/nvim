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
  enabled = false,
  config = function()
    local fzf = require("fzf-lua")
    local actions = require("fzf-lua.actions")

    fzf.setup({
      winopts = {
        -- width = 130,
        -- height = 25,
        row = 1,
        height = 20,
        width = 1,
        border = borders.full,
        preview = {
          title = false,
          border = "noborder", -- Only for native fzf previewers
          scrollbar = false,
          horizontal = "right:45%",
          winopts = {
            number = false,
          },
        },
      },
      files = {
        prompt = "Files> ",
        cwd_header = true,
        cwd_prompt = false,
        winopts = { preview = { hidden = "hidden" } },
        -- fzf_opts = { ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files-history" },
      },
      buffers = { preview = { hidden = "hidden" } },
      oldfiles = { preview = { hidden = "hidden" } },
      quickfix = { preview = { hidden = "hidden" } },
      quickfix_stack = { preview = { hidden = "hidden" } },
      loclist = { preview = { hidden = "hidden" } },
      loclist_stack = { preview = { hidden = "hidden" } },
      args = { preview = { hidden = "hidden" } },
      grep = {
        winopts = { fullscreen = true },
        -- fzf_opts = { ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history" },
      },
      helptags = { winopts = { fullscreen = true } },
      lines = { winopts = { fullscreen = true, preview = { horizontal = "right:50%" } } },
      blines = { winopts = { fullscreen = true, preview = { horizontal = "right:50%" } } },
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
          ["<c-1>"] = "toggle-fullscreen",
          ["<c-2>"] = "toggle-preview",
          ["<c-3>"] = "toggle-preview-wrap",
          ["<c-4>"] = "toggle-preview-cw", -- Rotate preview clockwise
          ["<a-up>"] = "preview-page-up",
          ["<a-down>"] = "preview-page-down",
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
          ["alt-p"] = "toggle-preview",
          ["alt-w"] = "toggle-preview-wrap",
          ["alt-up"] = "preview-page-up",
          ["alt-down"] = "preview-page-down",
        },
      },
      actions = {
        files = {
          true,
          ["alt-q"] = false,
          ["alt-Q"] = false,
          ["enter"] = actions.file_edit,
          -- https://github.com/ibhagwan/fzf-lua/wiki#how-do-i-send-all-grep-results-to-quickfix-list
          ["ctrl-q"] = { prefix = "select-all+", fn = actions.file_sel_to_qf },
          ["ctrl-l"] = { prefix = "select-all+", fn = actions.file_sel_to_ll },
        },
      },
      help_open_win = function(buf, enter, opts)
        opts.border = borders.top
        return vim.api.nvim_open_win(buf, enter, opts)
      end,
    })

    -- https://github.com/ibhagwan/fzf-lua/pull/1127
    vim.g.fzf_history_dir = vim.fn.stdpath("data") .. "/fzf"

    G.nmap("<leader>p", fzf.builtin, { noremap = true, desc = "Pickers" })

    G.nmap("<leader>o", fzf.oldfiles, { noremap = true, desc = "Old Files" })

    G.nmap("<leader>h", fzf.helptags, { noremap = true, desc = "Help Tags" })

    G.nmap("<leader>b", fzf.buffers, { noremap = true, desc = "Buffers" })

    G.nmap("<leader>n", fzf.blines, { noremap = true, desc = "Buffer Lines" })

    G.nmap("<leader>g", fzf.git_branches, { noremap = true, desc = "Git branches" })

    G.nmap("<leader>f", function()
      fzf.files({ cwd = G.buf_cwd() })
    end, { noremap = true, desc = "Files" })

    G.nmap("<leader>s", function()
      fzf.live_grep({ cwd = G.buf_cwd() })
    end, { noremap = true, desc = "Live Grep" })
  end,
}
