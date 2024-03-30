return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
<<<<<<< HEAD
				theme = "catppuccin"
=======
				theme = "tokyonight"
>>>>>>> 0d6bd4b (adding rust lsp)
			},
		})
	end,
}
