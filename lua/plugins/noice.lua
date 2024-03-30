return {
  {
<<<<<<< HEAD
   "folke/noice.nvim", 
=======
    "folke/noice.nvim",
>>>>>>> 0d6bd4b (adding rust lsp)
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
<<<<<<< HEAD
  config = function()
=======
    config = function()
>>>>>>> 0d6bd4b (adding rust lsp)
      require("noice").setup({
        -- add any options here
        routes = {
          {
            filter = {
              event = 'msg_show',
              any = {
                { find = '%d+L, %d+B' },
                { find = '; after #%d+' },
                { find = '; before #%d+' },
                { find = '%d fewer lines' },
                { find = '%d more lines' },
              },
            },
            opts = { skip = true },
          }
        },
      })
    end,
  },
  "rcarriga/nvim-notify",
<<<<<<< HEAD
    config = function()
      require("notify").setup({
        background_colour = "#000001",
        enabled = true,
      })
    end
=======
  config = function()
    require("notify").setup({
      background_colour = "#000000",
      enabled = false,
    })
  end
>>>>>>> 0d6bd4b (adding rust lsp)
}
