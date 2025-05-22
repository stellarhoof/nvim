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

--[[
Default mappings:
- <c-j>: Expand snippet
- <c-l>: Move to next tabstop (wraps)
- <c-h>: Move to previous tabstop (wraps)
- <c-n>: Select next tabstop choice
- <c-p>: Select previous tabstop choice
- <c-c>: Stop current snippet session (works from any buffer). A session can
        also be stopped by exiting insert mode from the final tabstop.

How to trigger auto-completion on `<c-j>` where a completion menu is
presented if there are more than one snippet match and documentation pane is
open by default in this case. Otherwise it selects the only choice.

Can expanding a snippet perform actions such as adding imports?
--]]
local function setup_snippets()
  require("mini.snippets").setup({
    mappings = {
      -- Disable default `<c-j>` mapping since we're using blink.cmp to trigger
      -- snippet expansions.
      expand = "",
    },
  })
  G.au({ "VimEnter" }, {
    once = true,
    callback = function()
      table.insert(MiniSnippets.config.snippets, package_json_loader(G.root .. "/snippets"))
    end,
  })
end

local function setup_icons()
  require("mini.icons").setup()
  G.hl_link("MiniIconsAzure", "Normal")
  G.hl_link("MiniIconsBlue", "Normal")
  G.hl_link("MiniIconsCyan", "Normal")
  G.hl_link("MiniIconsGreen", "Normal")
  G.hl_link("MiniIconsGrey", "Normal")
  G.hl_link("MiniIconsOrange", "Normal")
  G.hl_link("MiniIconsPurple", "Normal")
  G.hl_link("MiniIconsRed", "Normal")
  G.hl_link("MiniIconsYellow", "Normal")
end

return {
  "https://github.com/echasnovski/mini.nvim",
  version = false,
  config = function()
    setup_snippets()
    -- setup_icons()
  end,
}
