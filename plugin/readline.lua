-- Readline motions and deletions in Neovim.
vim.pack.add(
  { "https://github.com/sysedwinistrator/readline.nvim" },
  {
    confirm = false,
  }
)

local readline = require("readline")

-- Move word
vim.keymap.set({ "i", "c" }, "<m-f>", readline.forward_word, { desc = "Forward word" })
vim.keymap.set(
  { "i", "c" }, "<m-b>", readline.backward_word,
  {
    desc = "Backward word",
  }
)

-- Move line
vim.keymap.set(
  { "i", "c" }, "<c-a>", readline.beginning_of_line,
  {
    desc = "Beginning of line",
  }
)
vim.keymap.set({ "i", "c" }, "<c-e>", readline.end_of_line, { desc = "End of line" })

-- Edit char
vim.keymap.set({ "i", "c" }, "<c-d>", "<delete>", { desc = "Forward Delete char" })
vim.keymap.set({ "i", "c" }, "<c-h>", "<bs>", { desc = "Backward delete char" })

-- Edit word
vim.keymap.set(
  { "i", "c" }, "<m-d>", readline.kill_word,
  {
    desc = "Forward kill word",
  }
)
vim.keymap.set(
  { "i", "c" }, "<m-bs>", readline.backward_kill_word, { desc = "Backward kill word" }
)

-- Edit line
vim.keymap.set(
  { "i", "c" }, "<c-k>", readline.kill_line,
  {
    desc = "Forward kill line",
  }
)
vim.keymap.set(
  { "i", "c" }, "<c-u>", readline.backward_kill_line, { desc = "Backward kill line" }
)
