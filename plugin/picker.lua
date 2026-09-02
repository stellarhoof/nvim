-- https://github.com/nvim-mini/mini.nvim/discussions/2523
-- https://github.com/edisj/msgarea.nvim
-- Interesting: https://github.com/comfysage/artio.nvim
-- TODO: helpgrep results
-- Project picker idea: https://github.com/nvim-mini/mini.nvim/discussions/1141

-- Fast file finder with fuzzy searching, frecency, and in-memory index.
later(function ()
  vim.pack.add({ "https://github.com/dmtrKovalenko/fff" }, { confirm = false })
end)

local function fullscreen_layout()
  return {
    anchor = "NW",
    row = 1,
    col = 1,
    width = vim.o.columns - 2,
    height = vim.o.lines - 2,
    border = { " ", " ", " ", " ", " ", " ", " ", " " },
  }
end

local function window_layout()
  local pos = vim.api.nvim_win_get_position(0)
  return {
    anchor = "NW",
    row = pos[1],
    col = pos[2],
    width = vim.api.nvim_win_get_width(0) - 2,
    height = vim.api.nvim_win_get_height(0) - 2,
    border = { " ", " ", " ", " ", " ", " ", " ", " " },
  }
end

local function centered_layout(_opts)
  local opts = vim.tbl_extend(
    "force", { height_per = 0.5, width_per = 0.5 }, _opts or {}
  )
  local height = math.floor(opts.height_per * vim.o.lines)
  local width = math.floor(opts.width_per * vim.o.columns)
  return {
    anchor = "NW",
    height = height,
    width = width,
    row = math.floor(0.5 * (vim.o.lines - height)),
    col = math.floor(0.5 * (vim.o.columns - width)),
  }
end

later(function ()
  local mini_pick, mini_extra = require("mini.pick"), require("mini.extra")

  mini_pick.setup({
    window = { config = centered_layout },
    mappings = {
      execute = {
        char = "<c-q>",
        func = function ()
          local key = vim.api.nvim_replace_termcodes("<c-a><m-cr>", true, false, true)
          vim.api.nvim_feedkeys(key, "n", false)
        end,
      },
    },
  })

  mini_extra.setup()

  vim.api.nvim_set_hl(0, "MiniPickMatchRanges", { link = "Keyword" })

  vim.keymap.set({ "n" }, "<leader>,", function ()
    mini_pick.builtin.buffers({
      window = { config = window_layout },
    })
  end, { desc = "Buffers" }
  )

  vim.keymap.set({ "n" }, "<leader>f", function ()
    mini_pick.builtin.files({}, {
      source = { cwd = vim.b.dir },
      window = { config = window_layout },
    })
  end, { desc = "Files" }
  )

  vim.keymap.set({ "n" }, "<leader>i", function ()
    require("site.mini.pick.fff")({
      window = { config = window_layout },
    })
  end, { desc = "Indexed Files" }
  )

  vim.keymap.set({ "n" }, "<leader>s", function ()
    mini_pick.builtin.grep_live({}, {
      source = { cwd = vim.b.dir },
      window = { config = fullscreen_layout },
    })
  end, { desc = "Grep results" }
  )

  vim.keymap.set({ "n" }, "<leader>?", function ()
    mini_pick.builtin.help()
  end, { desc = "Help results" }
  )

  vim.keymap.set({ "n" }, "<leader>h", function ()
    mini_extra.pickers.oldfiles({}, {
      window = { config = window_layout },
    })
  end, { desc = "Oldfiles" }
  )

  vim.keymap.set({ "n" }, "<leader>b", function ()
    mini_extra.pickers.git_branches()
  end, { desc = "Git branches" }
  )
end)
