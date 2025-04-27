-- https://github.com/yioneko/vtsls/issues/242
local function typescript_root_dir(filename)
  local root_pattern = require("lspconfig.util").root_pattern

  -- Sounds like a good idea until you realize you can't jump to definitions
  -- from library to library :(
  -- -- Disable if file is inside node_modules
  -- if string.find(filename, "node_modules/") then
  -- 	return nil
  -- end

  -- Support monorepos by resolving to the root project
  local dir = root_pattern(".git")(filename)
  if dir and vim.fn.globpath(dir, "tsconfig.json") ~= "" then
    return dir
  end

  return root_pattern("tsconfig.json", ".git", "jsconfig.json", "package.json")(filename)
end

-- TODO: Investigate https://github.com/pmizio/typescript-tools.nvim
return {
  -- root_dir = typescript_root_dir,
  -- https://github.com/yioneko/vtsls/blob/41ad8c9d3f9dbd122ce3259564f34d020b7d71d9/packages/service/configuration.schema.json
  settings = {
    typescript = {
      updateImportsOnFileMove = "always",
      preferTypeOnlyAutoImports = true,
      tsserver = {
        maxTsServerMemory = 6144,
      },
    },
    vtsls = {
      -- https://github.com/yioneko/vtsls#typescript-version
      autoUseWorkspaceTsdk = true,
      enableMoveToFileCodeAction = true,
      -- This may make completions more performant
      -- experimental.completion.enableServerSideFuzzyMatch
    },
  },
  on_attach = function(_, bufnr)
    G.nmap("grs", require("vtsls").commands.source_actions, {
      buffer = bufnr,
      desc = "Select source action",
    })

    G.nmap("grm", function()
      local old_fpath = vim.fn.expand("%")
      vim.ui.input({
        prompt = "Rename file and update imports",
        default = old_fpath,
      }, function(new_fpath)
        require("vtsls").rename(
          vim.fn.fnamemodify(old_fpath, ":p"),
          vim.fn.fnamemodify(new_fpath, ":p")
        )
      end)
    end, {
      buffer = bufnr,
      desc = "Rename file",
    })

    -- Non refactoring mappings

    G.nmap("<leader>li", require("vtsls").commands.file_references, {
      buffer = bufnr,
      desc = "List sites where current file is imported",
    })

    G.nmap("gd", require("vtsls").commands.goto_source_definition, {
      buffer = bufnr,
      desc = "Goto source definition of symbol under cursor",
    })
  end,
}
