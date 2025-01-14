return {
	{
		--rosyln
		"seblj/roslyn.nvim",
		ft = "cs",
		config = true,
		opts = {
			-- your configuration comes here; leave empty for default settings
		},
	},
	{
		"tris203/rzls.nvim", -- Razor LSP support
		dependencies = {
			"seblj/roslyn.nvim", -- C# Language server plugin
		},
		config = true,
	},
	--syntax highlighting for razor
	{
		"adamclerk/vim-razor", -- razor syntax highlighting
		ft = "razor",
	},
}
