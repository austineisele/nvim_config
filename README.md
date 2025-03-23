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
- Leader then 't' in normal mode toggles a horizontal terminal on the bottom of the window
 
### Debugging
- Leader then "bp" in normal mode to toogle a breakpoint
- <F5> starts or continues a debugging
- Leader then "dx" in normal mode stops a debugging session
- <F10> steps over

### Harpoon
- Leader "a" - Add a file to Harpoon
- Leader "h" - Toggle the Harpoon Menu
- Leader 1 through 5 - Move to a certain file

