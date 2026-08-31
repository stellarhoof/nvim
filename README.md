# Links

[How to write a linter using tree-sitter in an hour](https://siraben.dev/2022/03/22/tree-sitter-linter.html)
[Lua wiki](http://lua-users.org/wiki/LuaDirectory)
[Lua manual](http://www.lua.org/manual/5.4/)
[Neovim wrapper with Nix from scratch](https://ayats.org/blog/neovim-wrapper)

# Terminals

- https://github.com/thdxg/macterm
- https://github.com/umputun/agterm
- https://github.com/manaflow-ai/cmux
- https://github.com/coder/mux
- https://github.com/supabitapp/supacode
- https://github.com/neurosnap/zmx
- https://github.com/stablyai/orca
- https://github.com/nicosuave/gmx

# TODO

- Extract code into function
- Extract code/function into file
- Make component props into object and viceversa
- Make component from () into {return}
- Exit current block in insert mode via <tab> or another keybinding. Use matchup plugin instead of tabout
- Setup debugging
- Picker: Cycle through list of cwds
- Lists of quickfix lists
- Jump to identifier references without populating quickfix

# Plugins

https://github.com/andrewferrier/debugprint.nvim

- https://github.com/ThePrimeagen/refactoring.nvim has all the features I need
- In case I need more, https://github.com/chrisgrieser/nvim-chainsaw is smaller

https://github.com/rgroli/other.nvim
https://github.com/kevinhwang91/nvim-bqf
https://github.com/CKolkey/ts-node-action
https://github.com/Wansmer/treesj (api is too messy)
https://github.com/inkarkat/vim-UnconditionalPaste
https://github.com/ThePrimeagen/refactoring.nvim
https://github.com/noisesfromspace/touchup.nvim
https://github.com/nemanjamalesija/ts-expand-hover.nvim
https://github.com/celeste3z/celeste_comment.nvim
https://github.com/zgs225/pi2.nvim
https://github.com/mawkler/jsx-element.nvim
https://github.com/chrisgrieser/nvim-genghis
https://github.com/y3owk1n/time-machine.nvim
https://github.com/igorlfs/nvim-dap-view
https://github.com/kndndrj/nvim-dbee

## Plugins to improve diff mode

https://github.com/CoreyKaylor/diffbandit.nvim
https://github.com/airblade/vim-gitgutter
https://github.com/Severeoverfl0w/difft.nvim

## Plugins with cool ideas

https://github.com/hasansujon786/nvim-navbuddy
https://github.com/stevanmilic/nvim-lspimport
https://github.com/mawkler/refjump.nvim
https://github.com/nemanjamalesija/ts-expand-hover.nvim
https://github.com/chrisgrieser/nvim-rulebook
https://github.com/axieax/urlview.nvim
https://github.com/TheLazyCat00/termfile-nvim
https://github.com/CarGDev/codetyper.nvim
https://github.com/jfojtl/intent-diff.nvim
https://github.com/XXiaoA/encore.nvim

# Interesting

https://github.com/ast-grep/ast-grep
https://old.reddit.com/r/neovim/comments/1vj4zcp/neovim_the_session_revolution/

# Useful help pags

- |default-mappings|
- |option-list|
- |standard-plugin-list|

# Options

Run `:options` for an interactive list of all current options.

Options values can be one if the following types:

- global : Global only.
- global-local : Global but can be overridden per buffer/window.
- local : Per buffer/window; has mutable global defaults that are copied from upon creating new buffers/windows.
- local-noglobal : Per buffer/window; does not have mutable global defaults.

- Window local values are remembered for each buffer.

Lua interface for options (see `:h lua-options`)

- `vim.o` : gets or sets options (like `:set`)
- `vim.go` : gets or sets global options (like `:setglobal`)
- `vim.bo` : gets or sets buffer local options (like `:setlocal`)
- `vim.wo` : gets or sets window local options (like `:setlocal`)
- `vim.opt` : gets or sets list/map style options (like `:set`)
- `vim.opt_local` : gets or sets list/map style options (like `:setlocal`)
- `vim.opt_global`: gets or sets list/map style options (like `:setglobal`)
