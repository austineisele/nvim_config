-- nvim 0.11+ LSP setup using only `vim.lsp.config` and `vim.lsp.enable`
-- Removed deprecated `require("lspconfig/util")`
-- Removed Razor (rzls) and Roslyn setup as requested
-- See :help lsp and https://github.com/neovim/nvim-lspconfig

-- Shared on_attach and capabilities -----------------------------------------
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })

	if client:supports_method("textDocument/foldingRange") then
		vim.o.foldmethod = "expr"
		vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
	end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Helper to merge common fields into per-server configs
local function with_common(cfg)
	cfg = cfg or {}
	cfg.capabilities = cfg.capabilities or capabilities
	cfg.on_attach = cfg.on_attach or on_attach
	return cfg
end

-- LUA ------------------------------------------------------------------------
vim.lsp.config("lua_ls", with_common({}))
vim.lsp.enable("lua_ls")

-- C# (csharp_ls) -------------------------------------------------------------
vim.lsp.config("csharp_ls", with_common({}))
vim.lsp.enable("csharp_ls")

-- Go (gopls) -----------------------------------------------------------------
vim.lsp.config(
	"gopls",
	with_common({
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_markers = { "go.work", "go.mod", ".git" },
	})
)
vim.lsp.enable("gopls")

-- HTML -----------------------------------------------------------------------
vim.lsp.config(
	"html",
	with_common({
		capabilities = html_cap,
		filetypes = { "html", "tmpl" },
	})
)
vim.lsp.enable("html")

--tailwind---------------------------------------------------------------------
vim.lsp.config(
	"tailwind_ls",
		with_common({
			cmd = { "tailwindcss-language-server", "--stdio" },
	})
)
vim.lsp.enable("tailwind_ls")
-- Emmet (emmet_ls) -----------------------------------------------------------
vim.lsp.config(
	"emmet_ls",
	with_common({
		filetypes = {
			"html",
			"css",
			"scss",
			"sass",
			"less",
			"javascriptreact",
			"typescriptreact",
			"svelte",
		},
		init_options = {
			html = {
				options = {
					["bem.enabled"] = true,
				},
			},
		},
	})
)
vim.lsp.enable("emmet_ls")

-- Svelte ---------------------------------------------------------------------
vim.lsp.config("svelte", with_common({}))
vim.lsp.enable("svelte")

-- TypeScript/JavaScript ------------------------------------------------------
vim.lsp.config(
	"ts_ls",
	with_common({
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"javascript",
			"javascriptreact",
			"javascript.jsx",
		},
		root_markers = {
			"tsconfig.json",
			"jsconfig.json",
			"package.json",
			".git",
		},
	})
)
vim.lsp.enable("ts_ls")

-- Python (pyright) -----------------------------------------------------------
vim.lsp.config(
	"pyright",
	with_common({
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = { "python" },
		single_file_support = true,
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					useLibraryCodeForTypes = true,
				},
			},
		},
	})
)
vim.lsp.enable("pyright")

-- YAML -----------------------------------------------------------------------
vim.lsp.config(
	"yamlls",
	with_common({
		settings = {
			yaml = {
				schemas = {
					["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml"] = "/*",
				},
			},
		},
	})
)
vim.lsp.enable("yamlls")

-- Keymaps & minor UX ---------------------------------------------------------
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float, {})
vim.lsp.inlay_hint.enable = true

-- Plugins list ---------------------------------------------------------------
return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({ PATH = "prepend" })
		end,
		registries = {
			"github:mason-org/mason-registry",
			"github:crashdummyy/mason-registry",
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = { auto_install = true },
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function() end,
	},
}

