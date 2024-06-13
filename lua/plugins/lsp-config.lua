return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				PATH = "prepend",
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			--lua lsp set up
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			--Omnisharp set up
			local pid = vim.fn.getpid()
			local omnisharp_bin =
				"C:\\Users\\aeisele\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp-mono\\omnisharp.exe"
			lspconfig.omnisharp.setup({
				cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
				enable_editorconfig_support = true,
				enable_ms_build_load_projects_on_demand = false,
				enable_rosyln_analzyers = true,
				root_dir = lspconfig.util.root_pattern("*.csproj", "*.sln"),
				capabilities = capabilities,
				handlers = {
					["textDocument/definition"] = require("omnisharp_extended").handler,
				},
			})

      require("lspconfig").pyright.setup({
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				--root_dir = function(startpath)
				--       return M.search_ancestors(startpath, matcher)
				--  end,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
						},
					},
				},
				single_file_support = true,
			})
			--keybindingavim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
