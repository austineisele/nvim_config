return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
<<<<<<< HEAD
    defaults = {
      file_ignore_patterns = { '%__virtual.cs$' },
    },
=======
>>>>>>> 0d6bd4b (adding rust lsp)
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
<<<<<<< HEAD
=======

>>>>>>> 0d6bd4b (adding rust lsp)
      require("telescope").load_extension("ui-select")

    end,
  },
}
