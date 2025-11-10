local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.shadafile = vim.fn.stdpath("data") .. "/shada/main.shada"

--plugin manager
require("vim-options")
require("lazy").setup("plugins")

vim.cmd.colorscheme("catppuccin")

vim.opt.list = true
vim.opt.shellslash = true
vim.opt.shell = "bash"
vim.opt.shellxquote = '""'
vim.api.nvim_command("autocmd VimEnter * let &shellcmdflag = '-c'")
vim.api.nvim_command("autocmd VimEnter * let &shell='\"C:/Users/aeisele/AppData/Local/Programs/Git/bin/bash.exe\"'")

-- zoom function

if vim.g.vscode then
  local function map(mode, lhs, cmd)
    vim.keymap.set(mode, lhs, function()
      vim.fn.VSCodeNotify(cmd)
    end, { silent = true, noremap = true })
  end

end
vim.g.terminal_emulator = "zsh"
