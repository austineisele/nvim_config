vim.api.nvim_create_autocmd("BufWritePre",{
  pattern = "*.md, *.txt",
  command = "pencil#init()"
})
