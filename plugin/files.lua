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
      -- Set custom bookmarks
      mini_files.set_bookmark("~", "~", { desc = "Home directory" })
      mini_files.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
      mini_files.set_bookmark("p", "~/Projects/github.com/stellarhoof", {
        desc = "My projects",
      })
      mini_files.set_bookmark("n", "~/Projects/github.com/stellarhoof/notes", {
        desc = "Notes",
      })
      mini_files.set_bookmark("c", vim.fn.stdpath("config") .. "", { desc = "Config" })
    end,
  })

  local function with_cwd(callback)
    local state = require("mini.files").get_explorer_state()
    if state then
      callback(state.branch[state.depth_focus])
    end
  end

  local rhs = function (direction)
    return function ()
      -- Make new window and set it as target
      local state = mini_files.get_explorer_state()
      if state then
        local new_target = vim.api.nvim_win_call(state.target_window, function ()
          vim.cmd(direction .. " split")
          return vim.api.nvim_get_current_win()
        end)
        mini_files.set_target_window(new_target)
      end
    end
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function (args)
      local buf_id = args.data.buf_id

      vim.keymap.set({ "n" }, "<c-c>", mini_files.close, {
        buffer = buf_id,
        desc = "Exit",
      })

      vim.keymap.set({ "n" }, "<c-s>", rhs("horizontal"), {
        buffer = buf_id,
        desc = "Split horizontal",
      })
      vim.keymap.set({ "n" }, "<c-v>", rhs("vertical"), {
        buffer = buf_id,
        desc = "Split belowright vertical",
      })
      vim.keymap.set({ "n" }, "<c-t>", rhs("tab"), {
        buffer = buf_id,
        desc = "Open in new tab",
      })

      -- Set custom mappings
      vim.keymap.set({ "n" }, "<leader>s", function ()
        with_cwd(function (cwd)
          mini_files.close()
          require("mini.pick").builtin.grep_live({}, { source = { cwd = cwd } })
        end)
      end, { buffer = buf_id }
      )

      vim.keymap.set({ "n" }, "<leader>f", function ()
        with_cwd(function (cwd)
          mini_files.close()
          require("mini.pick").builtin.files({}, { source = { cwd = cwd } })
        end)
      end, { buffer = buf_id }
      )
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
