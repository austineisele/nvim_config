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
          ["textDocument/definition"] = require('omnisharp_extended').handler,
        }
      })

      --keybindingavim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
			--Omnisharp set up
			local pid = vim.fn.getpid()
			local omnisharp_bin =
				"C:\\Users\\aeisele\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\omnisharp.cmd"
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

      lspconfig.rust_analyazer.setup({
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = false;
            }
          }
        }
      })

			--keybindinga
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
