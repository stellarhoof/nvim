-- https://github.com/ibhagwan/fzf-lua
-- https://github.com/nvim-mini/mini.nvim/discussions/2523
-- https://github.com/comfysage/artio.nvim

-- Fast file finder with fuzzy searching, frecency, and in-memory index.
later(function ()
  vim.api.nvim_create_autocmd("PackChanged", {
    pattern = { "fff" },
    callback = function (ev)
      if ev.data.kind == "install" or ev.data.kind == "update" then
        if not ev.data.active then vim.cmd.packadd('fff.nvim') end
        require("fff.download").download_or_build_binary()
      end
    end,
  })
  vim.pack.add({ "https://github.com/dmtrKovalenko/fff" }, { confirm = false })
end)

later(function ()
  local pick, extra = require("mini.pick"), require("mini.extra")

  pick.setup()
  extra.setup()
  pick.registry.fffiles = require("site.mini.pick.fff")

  vim.keymap.set({ "n" }, "<leader>,", function ()
    pick.builtin.buffers()
  end, { desc = "Buffers" }
  )

  vim.keymap.set({ "n" }, "<leader>s", function ()
    pick.builtin.grep_live({}, {
      window = {
        config = function ()
          return { row = 0, col = 0, width = vim.o.columns, height = vim.o.lines }
        end,
      },
    })
  end, { desc = "Grep results" }
  )

  vim.keymap.set({ "n" }, "<leader>?", function ()
    pick.builtin.help({ default_split = "vertical" }, {
      window = {
        config = function ()
          return { row = 0, col = 0, width = vim.o.columns, height = vim.o.lines }
        end,
      },
    })
  end, { desc = "Help results" }
  )

  vim.keymap.set({ "n" }, "<leader>h", function ()
    extra.pickers.oldfiles()
  end, { desc = "Oldfiles" }
  )

  vim.keymap.set({ "n" }, "<leader>f", function ()
    pick.registry.fffiles()
  end, { desc = "Snacks.picker.git_files" }
  )

  vim.keymap.set({ "n" }, "<leader>b", function ()
    extra.pickers.git_branches()
  end, { desc = "Snacks.picker.git_branches" }
  )
end)
