return {
		"preservim/vim-pencil",
		ft = { "markdown", "text" },
		config = function()
			vim.fn["pencil#init"]({ wrap = "soft", spell = 0 })
		end,
	}

