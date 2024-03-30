<<<<<<< HEAD
--prelims
local util = require("lspconfig/util")

--on attach specifically for rzls
local on_attach = function(client, bufnr)
  -- Create a command `:Format` local to the LSP buffer
  -- https://github.com/tris203/.dotfiles/blob/01f0bb1b5ebf950a61c69012c3c94dbc8cfb98f0/nvim/lua/lspattach.lua
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })

  if client:supports_method("textDocument/foldingRange") then
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
  end
end

--create the local functions that are doing the setup

--lua ls support:
local function lua_lsp_setup(capabilities)
	return {
		capabilities = capabilities,
	}
end

--the csharp lsp install via mason
local function csharp_lsp_setup(capabilities)
	return {
		capabilities = capabilities,
	}
end
--the rzls installed with the customer mason registry
local function rzls_setup(capabilities)
	return {
		config = {
			capabilities = capabilities,
      on_attach = on_attach,
		},
	}
end

--golang
local function gopls_setup(on_attach, capabilities)
	return {
		config = {
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = util.root_pattern("go.work", "go.mod", ".git"),
		},
	}
end

--configuration for neovm lsp
local function lsp_config(capabilities)
	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	lspconfig.lua_ls.setup(lua_lsp_setup(capabilities))
	lspconfig.csharp_ls.setup(csharp_lsp_setup(capabilities))
	lspconfig.gopls.setup(gopls_setup(on_attach, capabilities))

	capabilities.textDocument.completion.completionItem.snippetSupport = true

	require("rzls").setup(rzls_setup(capabilities))
	require("roslyn").setup({
		args = {
			"--logLevel=Information",
			"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
			"--razorSourceGenerator=" .. vim.fs.joinpath(
				vim.fn.stdpath("data") --[[@as string]],
				"mason",
				"packages",
				"roslyn",
				"libexec",
				"Microsoft.CodeAnalysis.Razor.Compiler.dll"
			),
			"--razorDesignTimePath=" .. vim.fs.joinpath(
				vim.fn.stdpath("data") --[[@as string]],
				"mason",
				"packages",
				"rzls",
				"libexec",
				"Targets",
				"Microsoft.NET.Sdk.Razor.DesignTime.targets"
			),
		},
		config = {
			handlers = require("rzls.roslyn_handlers"),
			settings = {
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = true,
					csharp_enable_inlay_hints_for_implicit_variable_types = true,
					csharp_enable_inlay_hints_for_lambda_parameter_types = true,
					csharp_enable_inlay_hints_for_types = true,
					dotnet_enable_inlay_hints_for_indexer_parameters = true,
					dotnet_enable_inlay_hints_for_literal_parameters = true,
					dotnet_enable_inlay_hints_for_object_creation_parameters = true,
					dotnet_enable_inlay_hints_for_other_parameters = true,
					dotnet_enable_inlay_hints_for_parameters = true,
					dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
					dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
					dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
				},
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = true,
				},
			},
		},
		init = function()
			vim.filetype.add({
				extension = {
					razor = "razor",
					cshtml = "razor",
				},
			})
		end,
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

	vim.keymap.set("n", "K", vim.lsp.buf.hover, {}) --hover over to see definition
	vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
	vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
	vim.lsp.inlay_hint.enable = true
end

=======
>>>>>>> 0d6bd4b (adding rust lsp)
return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				PATH = "prepend",
			})
		end,
<<<<<<< HEAD
		registries = {
			"github:mason-org/mason-registry",
			"github:crashdummyy/mason-registry",
		},
=======
>>>>>>> 0d6bd4b (adding rust lsp)
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
<<<<<<< HEAD
		event = { "BufReadPre", "BufNewFile" },
		config = lsp_config,
=======
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			--lua lsp set up
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = false,
						},
					},
				},
			})

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

			--keybindinga
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
>>>>>>> 0d6bd4b (adding rust lsp)
	},
}
