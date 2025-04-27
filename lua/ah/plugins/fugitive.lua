-- A Git wrapper so awesome, it should be illegal.

-- Copied from $VIMRUNTIME/lua/vim/_defaults.lua
local function open_uri(uri)
  if not uri or uri == "" then
    return "empty uri"
  end
  local cmd, err = vim.ui.open(uri)
  local rv = cmd and cmd:wait(1000) or nil
  if cmd and rv and rv.code ~= 0 then
    err = ("vim.ui.open: command %s (%d): %s"):format(
      (rv.code == 124 and "timeout" or "failed"),
      rv.code,
      vim.inspect(cmd.cmd)
    )
  end
  if err then
    return err
  end
end

return {
  "https://github.com/tpope/vim-fugitive",
  event = "VeryLazy",
  dependencies = { "https://github.com/tpope/vim-rhubarb" },
  config = function()
    local alias = vim.cmd.Alias
    alias({ args = { "g", "G" } })
    alias({ args = { "gbl", "Git blame -w -M" } })
    alias({ args = { "gd", "Gdiffsplit" } })
    alias({ args = { "ge", "Gedit" } })
    alias({ args = { "gr", "Gread" } })
    alias({ args = { "gs", "Git" } })
    alias({ args = { "gw", "Gwrite" } })
    alias({ args = { "gg", "Ggrep" } })
    alias({ args = { "gco", "Git checkout" } })
    alias({ args = { "gcm", "Git commit" } })
    alias({ args = { "gcma", "Git commit --amend" } })
    alias({ args = { "gcman", "Git commit --amend --reuse-message HEAD" } })

    local function cleanup_fugitive_windows()
      for _, winnr in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        local bufnr = vim.fn.winbufnr(winnr)
        if vim.startswith(vim.fn.bufname(bufnr), "fugitive://") then
          vim.cmd.bdelete(bufnr)
        end
      end
    end

    local function diff_current_quickfix_entry()
      local qf = vim.fn.getqflist({ idx = 0, title = 0, context = 0 })
      if qf.idx and qf.context and qf.context.items and string.find(qf.title, "difftool") then
        local item = qf.context.items[qf.idx]
        if item and item.diff then
          cleanup_fugitive_windows()
          vim.cmd.cc()
          vim.cmd.Gdiffsplit(item.diff[1].module)
        end
      end
    end

    G.nmap("[c", function()
      vim.cmd.cpfile()
      diff_current_quickfix_entry()
    end, { unique = false })

    G.nmap("]c", function()
      vim.cmd.cnfile()
      diff_current_quickfix_entry()
    end, { unique = false })

    local function get_active_visual_region()
      return vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = vim.fn.mode() })
    end

    local function get_active_visual_lines()
      return table.concat(vim.iter(get_active_visual_region()):map(vim.trim):totable())
    end

    local gx_desc =
      "Open filepath or URI under cursor or current file with system handler (file explorer, web browser, …)"

    vim.keymap.set({ "n" }, "gx", function()
      if open_uri(vim.fn.expand("<cfile>")) then
        vim.cmd.GBrowse()
      end
    end, { desc = gx_desc })

    vim.keymap.set({ "x" }, "gx", function()
      if open_uri(get_active_visual_lines()) then
        vim.cmd.GBrowse({ range = { vim.fn.line("v"), vim.fn.line(".") } })
      end
    end, { desc = gx_desc })

    -- Required by Fugitive to open a url since we're not using netrw.
    vim.api.nvim_create_user_command("Browse", function(args)
      open_uri(args.args)
    end, { nargs = 1 })
  end,
}
