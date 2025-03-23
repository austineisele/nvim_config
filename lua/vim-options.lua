vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.scrolloff = 10
vim.g.mapleader = " "
vim.keymap.set({ "n", "v"}, "<leader>y", [["+y"]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = vim.lsp.buf.format })
