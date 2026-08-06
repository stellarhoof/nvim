-- File explorer.
now(function ()
  -- Window width based on the offset from the center, i.e. center window
  -- is 60, then next over is 20, then the rest are 10.
  -- Can use more resolution if you want like { 60, 20, 20, 10, 5 }
  local widths = { 40, 20, 20 }

  local mini_files = require("mini.files")

  -- https://github.com/nvim-mini/mini.nvim/discussions/2173
  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesWindowUpdate",
    callback = function (ev)
      local state = mini_files.get_explorer_state()
      if state == nil then return end

      -- Compute "depth offset" - how many windows are between this and focused
      local path_this = vim
        .api
        .nvim_buf_get_name(ev.data.buf_id)
        :match("^minifiles://%d+/(.*)$")
      local depth_this
      for i, path in ipairs(state.branch) do
        if path == path_this then depth_this = i end
      end
      if depth_this == nil then return end
      local depth_offset = depth_this - state.depth_focus

      -- Adjust config of this event's window
      local i = math.abs(depth_offset) + 1
      local win_config = vim.api.nvim_win_get_config(ev.data.win_id)
      win_config.width = i <= #widths and widths[i] or widths[#widths]

      win_config.zindex = 99
      win_config.col = math.floor(0.5 * (vim.o.columns - widths[1]))
      local sign = depth_offset == 0 and 0 or (depth_offset > 0 and 1 or -1)
      for j = 1, math.abs(depth_offset) do
        -- widths[j+1] for the negative case because we don't want to add the center window's width
        local prev_win_width = (sign == -1 and widths[j + 1]) or widths[j]
          or widths[#widths]
        -- Add an extra +2 each step to account for the border width
        local new_col = win_config.col + sign * (prev_win_width + 2)
        if (new_col < 0) or (new_col + win_config.width > vim.o.columns) then
          win_config.zindex = win_config.zindex - 1
          break
        end
        win_config.col = new_col
      end

      win_config.height = depth_offset == 0 and 24 or 20
      win_config.row = math.floor(0.5 * (vim.o.lines - win_config.height))
      vim.api.nvim_win_set_config(ev.data.win_id, win_config)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesExplorerOpen",
    callback = function ()
      mini_files.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
      mini_files.set_bookmark("n", "~/Notes", { desc = "Notes" })
      mini_files.set_bookmark("c", vim.fn.stdpath("config") .. "", { desc = "Config" })
      mini_files.set_bookmark("p", vim.fn.stdpath("data") .. "/site/pack/core/opt", {
        desc = "Plugins",
      })
    end,
  })

  mini_files.setup({
    mappings = {
      go_in_plus = "<cr>",
      go_out_plus = "",
    },
  })

  vim.keymap.set({ "n" }, "<leader>e", function ()
    mini_files.open(vim.api.nvim_buf_get_name(0))
  end, { desc = "Files explorer" }
  )
end)
