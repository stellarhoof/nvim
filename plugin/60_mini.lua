-- Load now to have 'mini.misc' available for custom loading helpers.
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" }, { confirm = false })

-- The following helpers execute their function argument exactly once upon a
-- condition being met. Errors during the function's execution are reported as
-- |vim.notify()| warnings.

-- stylua: ignore start
_G.now = function(f) require('mini.misc').safely("now", f) end
_G.later = function(f) require('mini.misc').safely("later", f) end
_G.on_event = function(ev, f) require('mini.misc').safely("event:" .. ev, f) end
_G.on_filetype = function(ft, f) require('mini.misc').safely("filetype:" .. ft, f) end
-- stylua: ignore end

-- Icon provider. Used by other plugins to render icons.
require("mini.icons").setup({})

-- Statusline. See `:h 'statusline'` and `:h 'mini.statusline'`.
now(function()
  local function active_statusline()
    local mode, mode_hl = require("mini.statusline").section_mode({ trunc_width = 120 })
    local searchcount = require("mini.statusline").section_searchcount({ trunc_width = 75 })
    if searchcount ~= "" then
      searchcount = "󱎸 " .. searchcount
    end
    return require("mini.statusline").combine_groups({
      {
        hl = mode_hl,
        strings = { mode },
      },
      "%<", -- Mark general truncate point
      {
        hl = "MiniStatuslineFilename",
        strings = {
          require("mini.icons").get("filetype", vim.bo.filetype),
          require("mini.statusline").section_filename({ trunc_width = 140 }),
        },
      },
      "%=", -- End left alignment
      { hl = mode_hl, strings = { searchcount } },
    })
  end

  local function inactive_statusline()
    return require("mini.statusline").combine_groups({
      {
        hl = "MiniStatuslineFilename",
        strings = {
          require("mini.icons").get("filetype", vim.bo.filetype),
          require("mini.statusline").section_filename({ trunc_width = 140 }),
        },
      },
    })
  end

  require("mini.statusline").setup({
    content = {
      active = active_statusline,
      inactive = inactive_statusline,
    },
  })

  vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bold = true })
end)

-- Insert mode snippets. Mappings are:
-- - `<c-j>`: Expand snippet
-- - `<c-l>`: Move to next tabstop (wraps)
-- - `<c-h>`: Move to previous tabstop (wraps)
-- - `<c-n>`: Select next tabstop choice
-- - `<c-p>`: Select previous tabstop choice
-- - `<c-c>`: Stop current snippet session (works from any buffer)
later(function()
  require("mini.snippets").setup({})

  -- Provide snippet completion items via an in-process LSP server
  require("mini.snippets").start_lsp_server({})

  -- Load snippets using VSCode snippets manifest (`package.json` file) to map
  -- languages to their corresponding snippets files.
  --
  -- This function may be simplified by using some of the code in
  -- `MiniSnippets.gen_loader.from_runtime`
  local function package_json_loader(snippets_dir)
    -- Assert `package.json` file exists and is readable.
    local path = snippets_dir .. "/package.json"
    if vim.fn.filereadable(path) == 0 then
      vim.notify("Could not find snippets manifest at " .. path)
      return {}
    end

    -- Open and read `package.json`
    local file = io.open(path)
    if file == nil then
      vim.notify("Could not open " .. path)
      return {}
    end
    local raw = file:read("*all")
    file:close()

    -- Parse `package.json` contents
    local ok, contents = pcall(vim.json.decode, raw)
    if not (ok and type(contents) == "table") then
      vim.notify(ok and "Object is not a dictionary or array" or contents)
      return {}
    end

    -- Build `lang_patterns` table from snippets manifests. Ex:
    --
    -- {
    --   "html": { "html.json" },
    --   "tsx": { "javascript.json", "typescriptreact.json" }
    -- }
    local lang_patterns = {}
    for _, def in ipairs(contents.contributes.snippets) do
      for _, filetype in ipairs(def.language) do
        -- Map filetype to treesitter language because that is what
        -- `mini.snippets` understands. For example `typescriptreact` -> `tsx`.
        local lang = vim.treesitter.language.get_lang(filetype)
        if lang then
          if not lang_patterns[lang] then
            lang_patterns[lang] = {}
          end
          local filename = def.path:gsub("^%./", "")
          if not lang_patterns[lang][filename] then
            table.insert(lang_patterns[lang], filename)
          end
        end
      end
    end

    return function(context)
      local patterns = lang_patterns[(context or {}).lang]
      if not patterns then
        return {}
      end

      local snippets = {}
      for _, pattern in ipairs(patterns) do
        local loader = MiniSnippets.gen_loader.from_runtime(pattern)
        table.insert(snippets, loader(context))
      end

      return snippets
    end
  end

  table.insert(
    require("mini.snippets").config.snippets,
    package_json_loader(vim.fn.stdpath("config") .. "/snippets")
  )
end)

-- Insert mode completion.
later(function()
  local source_func = "omnifunc"

  require("mini.completion").setup({
    delay = {
      -- Disable autocomplete. Trigger via `i_<c-space>`.
      completion = math.huge,
      -- Disable automatic signature help popup. Trigger via `i_<c-s>`
      signature = math.huge,
    },
    lsp_completion = {
      source_func = source_func,
      -- Do not setup completion on `BufEnter`; it will be done on `LspAttach`.
      auto_setup = false,
      process_items = function(items, base)
        return require("mini.completion").default_process_items(
          items,
          base,
          -- Customize post-processing of LSP responses. Don't show 'Text'
          -- suggestions (usually noisy) and show snippets last.
          { kind_priority = { Text = -1, Snippet = 99 } }
        )
      end,
    },
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    desc = "Disable completion in some filetypes",
    pattern = "snacks*",
    callback = function()
      vim.b.minicompletion_disable = true
    end,
  })

  vim.api.nvim_create_autocmd({ "LspAttach" }, {
    callback = function(args)
      vim.bo[args.buf][source_func] = "v:lua.MiniCompletion.completefunc_lsp"
    end,
  })

  -- Advertise to servers that Neovim now supports certain set of completion and
  -- signature features through 'mini.completion'.
  vim.lsp.config("*", { capabilities = require("mini.completion").get_lsp_capabilities() })
end)

-- Show next key clues in a popup window. Useful for discovery of key mappings.
later(function()
  local miniclue = require("mini.clue")
  miniclue.setup({
    -- These keys trigger the clue window.
    triggers = {
      -- Leader triggers
      { mode = { "n", "x" }, keys = "<leader>" },
      { mode = { "n" }, keys = "<localleader>" },
      -- Built-in mapping groups
      { mode = { "n", "x" }, keys = "g" },
      { mode = { "n", "x" }, keys = "z" },
      { mode = { "n", "x" }, keys = "[" },
      { mode = { "n", "x" }, keys = "]" },
      -- Built-in completion
      { mode = { "i" }, keys = "<C-x>" },
      -- Registers
      { mode = { "n", "x" }, keys = '"' },
      { mode = { "i", "c" }, keys = "<c-r>" },
      -- Window commands
      { mode = { "n" }, keys = "<c-w>" },
    },
    -- Define which clues to show. User-defined mappings are picked
    -- automatically and don't need to be defined here.
    clues = {
      -- Built-in mappig groups
      miniclue.gen_clues.g(),
      miniclue.gen_clues.z(),
      miniclue.gen_clues.square_brackets(),
      -- Built-in completion
      miniclue.gen_clues.builtin_completion(),
      -- Registers
      miniclue.gen_clues.registers(),
      -- Window commands
      miniclue.gen_clues.windows(),
      -- Custom mappings
      { mode = { "n" }, keys = "<leader>d", desc = "+Diagnostics" },
      { mode = { "n" }, keys = "<leader>l", desc = "+LSP" },
      { mode = { "n" }, keys = "<leader>u", desc = "+UI" },
      { mode = { "n" }, keys = "<leader>k", desc = "+Snacks" },
      { mode = { "n" }, keys = "<leader>n", desc = "+Snippets" },
    },
    window = {
      config = { width = 60 },
    },
  })
end)
