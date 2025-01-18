return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  build = "cd app && yarn install",
  keys = {
    { "<leader>v", "<cmd>MarkdownPreview<CR>", noremap = true, silent = true, mode = "n" },
  },

  init = function()
    vim.api.nvim_exec(
      [[
function OpenMarkdownPreview (url)
    execute "silent ! open -a Safari " . a:url
endfunction
]],
      false
    )
    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_echo_preview_url = 1
  end,
}
