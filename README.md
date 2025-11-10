# Neovim and Tmux usage

## Important Neovim Keymaps
<u>Leader key</u>: <space>

### Lsp
- Leader then K in normal mode will give you a hover definition
- Leader then gd in normal mode will give you a goto definition
- Leader then gr will give you references to that item in your project
- Control then ',' will give you potential code actions

### Telescope
This is plugin allows you to nagivate around from the project's root
- Control then p in normal mode is a file finder.
- Leader then fg is a live grep, basically a fuzzy finder 

### Snacks
Plugin to control other plugins...
#### Navigation
- Leader `<space>`: Smart Find Files. Quickly open files in dir
- Leader `ff`: Find Files
- Leader `fp`: Look at Projects. From there, you can open files
- Leader `fr`: Look at recent files to open
- Leader `fb`: See recent buffers
- `[[`: Will jump to the next reference
- `]]`: Will jump to the prev reference

#### History
- Leader `:`: See recent commmands
- Leader `n`: Look at recent notifications
- Leader `s"`: Look at the register
- Leader `sm`: See current marks

#### Grep stuff
- Leader `sb`: See the lines in the bufers
- Leader `sB`: See the buffer for grep 
- Leader `sw`: Grep on a word that you're cursor is on

#### Git Stuff
- Leader `fg`: Find git files
- Leader `gb`: See git branches. You can checkout from here.
- Leader `gl`: Git log.
- Leader `gL`: Git log line.
- Leader `gs`: Git status. Looks at what is, and is not, being tracked
- Leader `gd`: Git diff of a file
- Leader `gg`: Opens LazyGit


#### Cool Stuff
- Leader `cR`: Rename a file
- Leader `sk`: Look at the keymaps.
- Leader `uC`: Set the color scheme. Brings menu with all schemes that are loaded. 
- Leader `sC`: Lists all the commands available
- Leader `z`: Toggle Zen mode
- Leader `.`: Toggle the scratch buffer. To write notes that you might need. 

### Neotree
Plugin for menus
- <F2> in normal mode reveals the dir tree left
- <F3> in normal mode reveals the toggles the tree
- <F4> in normal mode closes the tree
- < / > in normal mode allows you to filter
- when you are in the tree, 'a' add either a directory, or a file, depending on the level
- when you are in the tree, 'd' deletes either a directory or a file, depeneding on the level
- when you are in the tree, 'r' renames either a directory or a file, depeneding on the level

### Formatter
- Leader gf in normal mode formats code

### Terminal
- `<CR-/>` Toggles Terminal
 
### Debugging
- Leader then "bp" in normal mode to toogle a breakpoint
- <F5> starts or continues a debugging
- Leader then "dx" in normal mode stops a debugging session
- <F10> steps over

### Harpoon
- Leader "a" - Add a file to Harpoon
- Leader "h" - Toggle the Harpoon Menu
- Leader 1 through 5 - Move to a certain file

### Bash Shortcuts
- `rmain` Main erouters repo
- `rweb` SolidJs repo
- `sup` SupLib repo
- `flib` FormLib repo
- `fbl` fb-lib repo
alias rmain='cd /c/Users/aeisele/src/repos/eroutersnextgen'
alias rweb='cd /c/Users/aeisele/src/repos/eroutersnextgen/ElectronicRouters.SolidJS'
alias sup='cd /c/Users/aeisele/src/repos/SupLib'
alias flib='cd /c/Users/aeisele/src/repos/FormLib'
alias fbl='cd /c/Users/aeisele/src/repos/fb-lib'


### Useful vim commands
- Rename a variable across a project. 
    - Do a live grep with telescope. To add it to the quickfix, do `<CR-q>`
    - Once quickfix is populated:
    `:cdo s/foo/bar` 
    - Add `g` for all occurances, not just first, and `c` to confirm all



