local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

--plugin manager
require("vim-options")
require("lazy").setup("plugins")

<<<<<<< HEAD
vim.cmd.colorscheme("catppuccin")

local getOs = require("lua.utils.getOs")


if getOs.getName() == "Windows" then
    vim.opt.list = true
    vim.opt.shellslash = true
    vim.opt.shell = "bash"
    vim.opt.shellxquote = '""'
    vim.api.nvim_command("autocmd VimEnter * let &shellcmdflag = '-c'")
    vim.api.nvim_command("autocmd VimEnter * let &shell='\"C:/Program Files/Git/bin/bash.exe\"'")
else
	vim.g.terminal_emulator = "bash"
end
=======
>>>>>>> 0d6bd4b (adding rust lsp)
