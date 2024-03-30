return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
<<<<<<< HEAD
      require("catppuccin").setup({
        background = {
          dark = "mocha"
        },
        transparent_background = true,
        integrations = {
          neotree = true,
          treesitter = true,
          notify = true
        }
      })
=======
      vim.cmd.colorscheme "catppuccin"
>>>>>>> 0d6bd4b (adding rust lsp)
    end
  }
}
