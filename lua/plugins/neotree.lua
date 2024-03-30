return 
	{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
		config = function()
			 --neotree keymaps
			vim.keymap.set('n', '<F2>', ':Neotree filesystem reveal left<CR>', {})
			vim.keymap.set('n', '<F3>', ':Neotree toggle focus<CR>', {})
			vim.keymap.set('n', '<F4>', ':Neotree close<CR>', {})
      vim.keymap.set('n', '< / >', ':Neotree toggle curent_reveal_force_cwd<CR>', {})
		end
}
