G.misc.safely("now", function()
  -- Readline motions and deletions in Neovim.
  vim.pack.add({ "https://github.com/sysedwinistrator/readline.nvim" }, { confirm = false })

  local readline = require("readline")

  -- Move word
  G.map({ "i", "c" }, "<m-f>", readline.forward_word, { desc = "Forward word" })
  G.map({ "i", "c" }, "<m-b>", readline.backward_word, { desc = "Backward word" })

  -- Move line
  G.map({ "i", "c" }, "<c-a>", readline.beginning_of_line, { desc = "Beginning of line" })
  G.map({ "i", "c" }, "<c-e>", readline.end_of_line, { desc = "End of line" })

  -- Edit char
  G.map({ "i", "c" }, "<c-d>", "<delete>", { desc = "Forward Delete char" })
  G.map({ "i", "c" }, "<c-h>", "<bs>", { desc = "Backward delete char" })

  -- Edit word
  G.map({ "i", "c" }, "<m-d>", readline.kill_word, { desc = "Forward kill word" })
  G.map({ "i", "c" }, "<m-bs>", readline.backward_kill_word, { desc = "Backward kill word" })

  -- Edit line
  G.map({ "i", "c" }, "<c-k>", readline.kill_line, { desc = "Forward kill line" })
  G.map({ "i", "c" }, "<c-u>", readline.backward_kill_line, { desc = "Backward kill line" })
end)
