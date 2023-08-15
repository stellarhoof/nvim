local M = {
  "https://github.com/rktjmp/lush.nvim",
  cmd = "Lushify",
}

function M.init()
  au("BufWritePost", {
    group = aug("lush", {}),
    desc = "Update colorscheme whenever lush spec is changed",
    pattern = "*ah/plugins/lush/specs/*.lua",
    callback = function()
      package.loaded["ah.plugins.lush.nvim"] = nil
      require("ah.plugins.lush.nvim")("furnisher")
    end,
  })
end

return M
