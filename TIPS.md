# Useful help pags

- |default-mappings|
- |standard-plugin-list|

# Options

Run `:options` for an interactive list of all current options.

Options values can be one if the following types:
- global         : Global only.
- global-local   : Global but can be overridden per buffer/window.
- local          : Per buffer/window; has mutable global defaults that are copied from upon creating new buffers/windows.
- local-noglobal : Per buffer/window; does not have mutable global defaults.

- Window local values are remembered for each buffer.

Lua interface for options (see `:h lua-options`)

- `vim.o`         : gets or sets options (like `:set`)
- `vim.go`        : gets or sets global options (like `:setglobal`)
- `vim.bo`        : gets or sets buffer local options (like `:setlocal`)
- `vim.wo`        : gets or sets window local options (like `:setlocal`)
- `vim.opt`       : gets or sets list/map style options (like `:set`)
- `vim.opt_local` : gets or sets list/map style options (like `:setlocal`)
- `vim.opt_global`: gets or sets list/map style options (like `:setglobal`)

# Fugitive code review

1. Load all changed files between current branch and `base_branch` in quickfix list
   `Git difftool --name-status {base_branch}`

# Filtering a quickfix list

Have to `packadd cfilter` first

:Cfilter /{pat}/ - Create new list from entries matching {pat}

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
