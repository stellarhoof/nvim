-- Handle line and column numbers in file names.
vim.pack.add({ "https://github.com/wsdjeg/vim-fetch" }, { confirm = false })

later(function ()
  vim.pack.add({
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/lunarmodules/lua-mimetypes",
    "https://github.com/manoelcampos/xml2lua",
  }, { confirm = false })

  -- rest.nvim needs a few Lua dependencies that are normally installed through
  -- LuaRocks. Install them as regular packages and expose the ones that do not
  -- keep their modules under `lua/` on `package.path`.
  local function add_lua_root(filename)
    local file = vim.api.nvim_get_runtime_file(filename, false)[1]
    if file then
      package.path = vim.fn.fnamemodify(file, ":h") .. "/?.lua;" .. package.path
    end
  end

  add_lua_root("mimetypes.lua")
  add_lua_root("xml2lua.lua")

  vim.g.rest_nvim = {
    env = { enable = true },
    ui = { winbar = true },
    _log_level = vim.log.levels.WARN,
  }

  -- Load rest.nvim at startup so its `ftplugin` also runs when Neovim is started
  -- with an HTTP file as an argument.
  vim.pack.add({ "https://github.com/rest-nvim/rest.nvim" }, { confirm = false })

  vim.filetype.add({ extension = { http = "http", rest = "http" } })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "http" },
    callback = function ()
      vim.keymap.set("n", "<localleader>r", function ()
        vim.cmd("Rest run")
      end, { noremap = true, buffer = true, desc = "Run request under the cursor" }
      )
    end,
  })
end)

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
