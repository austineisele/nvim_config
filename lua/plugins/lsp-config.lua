-- prelims
local util = require("lspconfig/util")

-- on_attach (used by multiple servers)
local on_attach = function(client, bufnr)
  -- :Format for this buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })

  -- enable inlay hints across 0.9 → 0.11
  local ih = vim.lsp.inlay_hint
  if type(ih) == "function" then
    -- Neovim 0.9
    ih(bufnr, true)
  elseif type(ih) == "table" and type(ih.enable) == "function" then
    -- Neovim 0.10+
    ih.enable(true, { bufnr = bufnr })
  end

  -- folding (guarded)
  if client.supports_method and client:supports_method("textDocument/foldingRange") then
    -- vim.lsp.foldexpr() exists on 0.10+
    if vim.lsp and vim.lsp.foldexpr then
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end
end

-- create the local functions that are doing the setup

-- lua_ls
local function lua_lsp_setup(capabilities)
  return {
    capabilities = capabilities,
  }
end

-- csharp_ls (via mason)
local function csharp_lsp_setup(capabilities)
  return {
    capabilities = capabilities,
  }
end

-- rzls (top-level config table; optional cleanup)
local function rzls_setup(capabilities)
  return {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

-- gopls
local function gopls_setup(on_attach, capabilities)
  return {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  }
end

-- JavaScript / TypeScript (typescript-language-server)
local function tsserver_setup(on_attach, capabilities)
  return {
    on_attach = on_attach,
    capabilities = capabilities,
    -- Prefer leaving cmd unset so lspconfig uses default:
    -- cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript","javascriptreact","javascript.jsx",
      "typescript","typescriptreact","typescript.tsx",
    },
    root_dir = util.root_pattern("package.json","tsconfig.json","jsconfig.json",".git"),
    single_file_support = true,
  }
end

local function html_lsp_setup(on_attach, capabilities)
  return {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "tsx" },
    init_options = {
      providerFormatter = true,
    },
  }   
end

-- configuration for nvim-lsp
local function lsp_config()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- set snippetSupport BEFORE using capabilities
  capabilities.textDocument = capabilities.textDocument or {}
  capabilities.textDocument.completion = capabilities.textDocument.completion or {}
  capabilities.textDocument.completion.completionItem = capabilities.textDocument.completion.completionItem or {}
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- servers
  lspconfig.lua_ls.setup(lua_lsp_setup(capabilities))
  lspconfig.csharp_ls.setup(csharp_lsp_setup(capabilities))
  lspconfig.gopls.setup(gopls_setup(on_attach, capabilities))
  lspconfig.ts_ls.setup(tsserver_setup(on_attach, capabilities))  -- <= switch from tsserver → ts_ls
  lspconfig.html.setup(html_lsp_setup(on_attach, capabilities))

  -- Roslyn (guard to nvim >= 0.11)
  local v = vim.version()
  if v and (v.minor or 0) >= 11 then
    require("roslyn").setup({
      args = {
        "--logLevel=Information",
        "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        "--razorSourceGenerator=" .. vim.fs.joinpath(
          vim.fn.stdpath("data"), "mason", "packages", "roslyn", "libexec", "Microsoft.CodeAnalysis.Razor.Compiler.dll"
        ),
        "--razorDesignTimePath=" .. vim.fs.joinpath(
          vim.fn.stdpath("data"), "mason", "packages", "rzls", "libexec", "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"
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
          extension = { razor = "razor", cshtml = "razor" },
        })
      end,
    })
  else
    vim.notify("roslyn.nvim requires Neovim 0.11+", vim.log.levels.WARN)
  end

  -- pyright
  lspconfig.pyright.setup({
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
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

  -- keymaps
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
  vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
end

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        PATH = "prepend",
      })
    end,
    registries = {
      "github:mason-org/mason-registry",
      "github:crashdummyy/mason-registry",
    },
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
    event = { "BufReadPre", "BufNewFile" },
    config = lsp_config,
  },
}

