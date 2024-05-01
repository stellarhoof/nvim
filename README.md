# TODO

- Extract code into function
- Extract code/function into file
- Make component props into object and viceversa
- Make component from () into {return}
- Exit current block in insert mode via <tab> or another keybinding. Use matchup plugin instead of tabout
- Per lsp diagnostic counts

# Remember

- Telescope quickfix_history

# Mappings

https://vim.fandom.com/wiki/Unused_keys
https://gist.github.com/riceissa/bcaa6b509d5561e057c1ec95af5a7d72
Namespaces: g, -, <leader>, <alt>, c, d
Free: possibly ', |, Z, normal mode !, -, \_, +

# Articles

https://nanotipsforvim.prose.sh/
[How to write a linter using tree-sitter in an hour](https://siraben.dev/2022/03/22/tree-sitter-linter.html)
[Lua wiki](http://lua-users.org/wiki/LuaDirectory)
[Lua manual](http://www.lua.org/manual/5.4/)

# Per-tab bufferlists

https://github.com/tiagovla/scope.nvim
The plugin above is super simple: au on TabEnter, TabLeave, TabClosed, TabNewEntered and maintain a cache of buffers per tab and list/unlist buffers. Another option is to automatically populating the arglist for the current tab. Another plugin doing this: https://github.com/dosimple/workspace.vim. Also check this user's comment: https://www.reddit.com/r/neovim/comments/nktdgi/comment/gzf5lol/?utm_source=share&utm_medium=web2x&context=3

Probably a better idea is per-project bufferlists

# Treesitter

https://github.com/CKolkey/ts-node-action (too new, give it some time)
https://github.com/Wansmer/treesj (api is too messy)
https://github.com/ziontee113/syntax-tree-surfer

# Plugins

https://github.com/anuvyklack/pretty-fold.nvim
https://github.com/andrewferrier/debugprint.nvim
https://github.com/cbochs/grapple.nvim
https://github.com/cbochs/portal.nvim
https://github.com/carbon-steel/detour.nvim
https://github.com/OlegGulevskyy/better-ts-errors.nvim

## LSP

https://github.com/Bekaboo/dropbar.nvim
https://github.com/nvimdev/lspsaga.nvim
https://github.com/DNLHC/glance.nvim
https://github.com/jmbuhr/otter.nvim

# Telescope

- Cycle through list of cwds

https://github.com/rgroli/other.nvim
https://github.com/cljoly/telescope-repo.nvim
https://github.com/tsakirist/telescope-lazy.nvim
https://github.com/otavioschwanck/telescope-alternate.nvim
  - Stories
  - Tests
  - Types
  - Index files in pages

# Quickfix

### Navigating the quickfix list

:cc [nr] - Go to [nr] entry
:cn[ext] - Go to next entry that includes a filename
:cp[revious] - Go to previous entry that includes a filename
:cabo[ve] - Go to entry above the current line in the current buffer
:cbel[ow] - Go to entry below the current line in the current buffer
:cnf[ile] - Go to first entry in next file in the quickfix list that includes a filename
:cpf[ile] - Go to last entry in previous file in the quickfix list that includes a filename
:cfir[st] [nr] - Go to [nr] entry or first
:cla[st] [nr] - Go to [nr] entry or last

### Creating the quickfix list

:cf[ile] [file] - Read entries from file and go to to first entry
:cg[etfile] [file] - Read entries from file
:caddf[ile] [file] - Read entries from file and add them to current list
:cb[uffer] - Read entries from current buffer and go to first
:cgetb[uffer] - Read entries from current buffer
:cad[dbuffer] - Read entries from current buffer and add them to current list
:cex[pr] {expr} - Create list from {expr} and go to first entry
:cgete[xpr] {expr} - Create list from {expr}
:cadde[xpr] {expr} - Add entries to current list from {expr}

### Executing commands for each quickfix entry

:cdo {cmd} - Execute {cmd} on each entry
:cfdo {cmd} - Execute {cmd} on each file in the list

### Opening/closing quickfix window

:cope[n] - Open quickfix window
:ccl[ose] - Close quickfix window
:cw[indow] - Open quickfix window if there are entries. Close it when there are none.

### Moving through quickfix list stack

:col[der] - Go to older list
:cnew[er] - Go to newer list
:chi[story] - Show quickfix list stack

### Filtering a list

Have to `packadd cfilter` first

:Cfilter /{pat}/ - Create new list from entries matching {pat}

# Projects

Each of the following three things should be able to switch to each other
- Project picker (telescope) (list projects upwards and downwards)
- File picker (telescope)
- File browser (telescope)

- A buffer can have a list of upward project directories
  - Telescope files/git files should start on closest parent project directory and have the ability to go up the chain of project directories
    - Should also have the ability to switch to project picker
  - Same for file browser
  - Same for project listing
- There should be a way of finding all the project directories under a certain directory
  - There may be projects inside projects.
    - Monorepo.
      - Do not consider monorepo packages different projects because while working on a monorepo, sub-project reference each other and it's annoying to have to have to switch to a parent project to search sibling projects. Unless I can come up with a reasonable workflow.
    - Project dependencies.

- Should we make a distinction between dependencies and files the user controls?
  - User does not control dependencies
    - Dynamic so not practical to define upfront
  - User does control projects
    - Less dynamic, can define upfront

If I'm in a file in a contexture package I want
- See files for whole contexture
- See files scoped to current individual package
- See files scoped to other individual packages
Let's forget about this for now

# Code review

1. Load all changed files between current branch and `base_branch` in quickfix list
  `Git difftool --name-status {base_branch}`
