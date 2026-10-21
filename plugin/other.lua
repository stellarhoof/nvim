-- Handle line and column numbers in file names.
vim.pack.add({ "https://github.com/wsdjeg/vim-fetch" }, { confirm = false })

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

-- Check https://github.com/monkeymonk/prompt.nvim

later(function ()
  vim.pack.add({ "https://www.github.com/nvim-lua/plenary.nvim" })

  vim.pack.add({
    {
      src = "https://www.github.com/olimorris/codecompanion.nvim",
      version = vim.version.range("^20.0.0"),
    },
  })

  require("codecompanion").setup({
    interactions = {
      chat = {
        keymaps = {
          -- Change the map for the completion trigger
          completion = { modes = { n = "<tab>", i = "<tab>" }, opts = {} },
        },
        sessions = {
          enabled = true,
          autosave = true,
          continuous_save = true,
          save_dir = vim.fs.joinpath(
            vim.fn.stdpath("data"), "codecompanion", "sessions"
          ),
        },
      },
      cli = {
        agent = "pi",
        agents = {
          pi = { cmd = "pi" },
          auggie = { cmd = "auggie", description = "Augment Code" },
        },
      },
    },
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionChatCreated",
    callback = function ()
      vim.wo.winpinned = true
    end,
  })
end)
