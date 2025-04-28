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
    snippets = {
      -- Load snippets based on current language by reading files from
      -- "snippets/" subdirectories from 'runtimepath' directories.
      require("mini.snippets").gen_loader.from_lang(),
    },
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
