vim.o.relativenumber = true
vim.o.expandtab = true
vim.opt.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.g.mapleader = " "
--vim.g.terminal = '"C:/Program Files/Git/usr/bin/bash.exe"'
vim.o.listchars = "space:.,tab:|-"

function set_shell()
	if vim.loop.os_uname() "Windows_NT" then
		vim.opt.list = true
		vim.opt.shellslash = true
		vim.opt.shell = "bash"
		vim.opt.shellxquote = '""'
		vim.api.nvim_command("autocmd VimEnter * let &shellcmdflag = '-c'")
		vim.api.nvim_command("autocmd VimEnter * let &shell='\"C:/Program Files/Git/bin/bash.exe\"'")
	else
		vim.g.terminal_emulator = "zsh"
	end
end

