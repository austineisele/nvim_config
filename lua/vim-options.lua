vim.o.relativenumber = true
vim.o.expandtab = false
vim.opt.tabstop = 2
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.scrolloff = 10
vim.g.mapleader = " "
--vim.g.terminal = '"C:/Program Files/Git/usr/bin/bash.exe"'
vim.o.listchars = "space:.,tab:|-"
vim.o.foldlevelstart = 99
vim.keymap.set({ "n", "v"}, "<leader>y", [["+y"]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = vim.lsp.buf.format })
