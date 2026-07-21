now(function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "grug-far" },
    callback = function()
      vim.wo.signcolumn = "no"
      vim.api.nvim_set_hl(0, "GrugFarResultsPath", { link = "Directory" })
    end,
  })

  vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" }, { confirm = false })

  require("grug-far").setup({
    normalModeSearch = true,
    startInInsertMode = false,
    helpLine = { enabled = false },
    showCompactInputs = true,
    showInputsTopPadding = false,
    showStatusIcon = false,
    resultsSeparatorLineChar = " ",
    icons = {
      searchInput = "",
      replaceInput = "",
      filesFilterInput = "",
      flagsInput = "",
      pathsInput = "",
    },
    folding = {
      foldcolumn = "0",
    },
    resultLocation = {
      showNumberLabel = false,
    },
  })

  vim.keymap.set("n", "<leader>r", function()
    require("grug-far").open({ prefills = { paths = vim.b.dir } })
  end, { noremap = true, desc = "Open search and replace" })
end)
