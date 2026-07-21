now(function()
  vim.pack.add({ "https://github.com/folke/lazydev.nvim" }, { confirm = false })

  require("lazydev").setup({
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
    enabled = function(root_dir)
      -- Disable when a .luarc.json file is found
      return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
    end,
  })
end)
