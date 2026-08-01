-- Handle line and column numbers in file names.
vim.pack.add({ "https://github.com/wsdjeg/vim-fetch" }, { confirm = false })

-- Integration for https://pi.dev, the minimal coding agent
-- Check https://github.com/monkeymonk/prompt.nvim
-- Check https://github.com/dabstractor/pi-nvim-bridge
-- Check https://github.com/zgs225/pi2.nvim
later(function ()
  vim.pack.add({ "https://github.com/pablopunk/pi.nvim" }, { confirm = false })
end)

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "http" },
  callback = function ()
    vim.pack.add({ "https://github.com/mistweaverco/kulala.nvim" }, { confirm = false })

    require("kulala").setup({
      default_env = "dev",
      global_keymaps = false,
      kulala_keymaps = false,
      formatters = {
        json = { "jq", "." },
        xml = { "xmllint", "--format", "-" },
        html = { "xmllint", "--format", "--html", "-" },
      },
      ui = { max_response_size = 1024000 },
      treesitter = { enable = false },
    })

    vim.keymap.set("n", "<localleader>r", function ()
      require("kulala").run()
    end, { noremap = true, buffer = true, desc = "Run request under the cursor" }
    )
  end,
})
