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
