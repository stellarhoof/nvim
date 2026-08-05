-- https://github.com/nvim-mini/mini.nvim/discussions/2523
-- https://github.com/edisj/msgarea.nvim
-- Interesting: https://github.com/comfysage/artio.nvim

-- Fast file finder with fuzzy searching, frecency, and in-memory index.
later(function ()
  vim.pack.add({ "https://github.com/dmtrKovalenko/fff" }, { confirm = false })
end)

later(function ()
  local mini_pick, mini_extra = require("mini.pick"), require("mini.extra")

  mini_pick.setup()

  mini_extra.setup()

  mini_pick.registry.fffiles = require("site.mini.pick.fff")

  vim.api.nvim_set_hl(0, "MiniPickMatchRanges", { link = "Keyword" })

  vim.keymap.set({ "n" }, "<leader>,", function ()
    mini_pick.builtin.buffers()
  end, { desc = "Buffers" }
  )

  vim.keymap.set({ "n" }, "<leader>s", function ()
    mini_pick.builtin.grep_live({}, {
      window = {
        config = function ()
          return { row = 0, col = 0, width = vim.o.columns, height = vim.o.lines }
        end,
      },
    })
  end, { desc = "Grep results" }
  )

  vim.keymap.set({ "n" }, "<leader>?", function ()
    mini_pick.builtin.help({ default_split = "vertical" }, {
      window = {
        config = function ()
          return { row = 0, col = 0, width = vim.o.columns, height = vim.o.lines }
        end,
      },
    })
  end, { desc = "Help results" }
  )

  vim.keymap.set({ "n" }, "<leader>h", function ()
    mini_extra.pickers.oldfiles()
  end, { desc = "Oldfiles" }
  )

  vim.keymap.set({ "n" }, "<leader>f", function ()
    mini_pick.registry.fffiles()
  end, { desc = "Files" }
  )

  vim.keymap.set({ "n" }, "<leader>b", function ()
    mini_extra.pickers.git_branches()
  end, { desc = "Git branches" }
  )
end)
