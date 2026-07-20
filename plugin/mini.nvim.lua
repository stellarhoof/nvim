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

local function setup_snippets()
  -- <c-j>: Expand snippet
  -- <c-l>: Move to next tabstop (wraps)
  -- <c-h>: Move to previous tabstop (wraps)
  -- <c-n>: Select next tabstop choice
  -- <c-p>: Select previous tabstop choice
  -- <c-c>: Stop current snippet session (works from any buffer)
  require("mini.snippets").setup({})

  -- Provide snippet completion items via an in-process LSP server
  require("mini.snippets").start_lsp_server({})

  G.misc.safely("later", function()
    table.insert(
      MiniSnippets.config.snippets,
      package_json_loader(vim.fn.stdpath("config") .. "/snippets")
    )
  end)
end

local function setup_completion()
  local source_func = "omnifunc"

  require("mini.completion").setup({
    delay = {
      -- Disable autocomplete. Trigger via `i_<c-space>`.
      completion = math.huge,
      -- Disable automatic popup of signature help. Trigger via `i_<c-s>`
      signature = math.huge,
    },
    lsp_completion = {
      source_func = source_func,
      auto_setup = false, -- Do not setup completion on `BufEnter`
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
end

G.misc.safely("now", function()
  vim.pack.add({ "https://github.com/echasnovski/mini.nvim" }, { confirm = false })
  setup_snippets()
  setup_completion()
  require("mini.icons").setup({})
  require("mini.icons").mock_nvim_web_devicons()
end)
