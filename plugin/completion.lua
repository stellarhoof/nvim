-- Ignore case when completing file names and directories.
vim.o.wildignorecase = true

-- Options for insert mode completion (doesn't apply to cmdline completion).
vim.opt.completeopt = {
  -- Enable fuzzy matching.
  "fuzzy",
  -- Show popup menu for completions even when there's only one match.
  "menuone",
  -- Do not automatically select a completion item.
  "noinsert",
  -- Show extra information about the currently selected item in a popup window.
  "popup",
}

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Disable mini.completion in some filetypes",
  pattern = { "snacks_picker_input", "markdown", "gitcommit" },
  callback = function ()
    vim.b.minicompletion_disable = true
  end,
})

-- Insert mode completion.
later(function ()
  local source_func = "omnifunc"

  require("mini.completion").setup({
    delay = {
      -- Disable automatic signature help popup. Trigger via `i_<c-s>`
      signature = math.huge,
    },
    lsp_completion = {
      source_func = source_func,
      -- Do not setup completion on `BufEnter`; it will be done on `LspAttach`.
      auto_setup = false,
      process_items = function (items, base)
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

  -- Advertise to servers that which signature/completion features neovim supports.
  vim.lsp.config("*", {
    capabilities = require("mini.completion").get_lsp_capabilities(),
  })

  vim.api.nvim_create_autocmd({ "LspAttach" }, {
    desc = "Use mini.completion as lsp's " .. source_func,
    callback = function (args)
      vim.bo[args.buf][source_func] = "v:lua.MiniCompletion.completefunc_lsp"
    end,
  })
end)
