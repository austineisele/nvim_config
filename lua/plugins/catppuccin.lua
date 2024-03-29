return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
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
    end
  }
}
