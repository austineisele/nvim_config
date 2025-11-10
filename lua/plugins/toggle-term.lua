return {
  {
    "akinsho/nvim-toggleterm.lua",
    cmd = { "TermExec", "ToggleTerm" },
    keys = {
      { "<leader>t", "<cmd>ToggleTerm<CR>" },
    },
    config = function()
      require("toggleterm").setup({
        -- size can be a number or function which is passed the current terminal
        -- size = 20 | function(term)
        function(term)
          if term.direction == "horizontal" then
            return 20
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        hide_numbers = false, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = false, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
        direction = "horizontal",
        close_on_exit = true, -- close the terminal window when the process exits
        shell = zsh,      -- change the default shell
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          border = "curved",
          winblend = 3,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
      local n_opts = { silent = true, noremap = true }
      local t_opts = { silent = true }

      local keymap = vim.keymap.set

      -- Normal mode
      -- Better window navigation
      keymap("n", "<C-Left>", "<C-w>h", n_opts)
      keymap("n", "<C-Down>", "<C-w>j", n_opts)
      keymap("n", "<C-Up>", "<C-w>k", n_opts)
      keymap("n", "<C-Right>", "<C-w>l", n_opts)

      -- Terminal mode
      keymap("t", "<esc>", "<C-\\><C-N>", t_opts)
      keymap("t", "<C-Left>", "<C-\\><C-N><C-w>h", t_opts)
      keymap("t", "<C-Down>", "<C-\\><C-N><C-w>j", t_opts)
      keymap("t", "<C-Up>", "<C-\\><C-N><C-w>k", t_opts)
      keymap("t", "<C-Right>", "<C-\\><C-N><C-w>l", t_opts)
    end,
  },
}
