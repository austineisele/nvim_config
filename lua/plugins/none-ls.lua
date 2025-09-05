return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    -- Use Prettier for HTML (and friends). prefer_local uses your project's local prettier if available.
    local prettier = null_ls.builtins.formatting.prettier.with({
      prefer_local = "node_modules/.bin",
      filetypes = {
        -- HTML
        "html",

        -- Common web formats that Prettier also handles nicely
        "css",
        "scss",
        "less",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "yaml",
        "markdown",
        "markdown.mdx",
      },
    })

    -- OPTIONAL: If you want a dedicated HTML formatter instead of Prettier,
    -- uncomment the next line (requires the `htmlbeautifier` Ruby gem installed).
    -- local htmlbeautifier = null_ls.builtins.formatting.htmlbeautifier

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        prettier,
        -- htmlbeautifier, -- <- enable if you want this instead / in addition
        null_ls.builtins.diagnostics.erb_lint,
        require("none-ls.diagnostics.eslint_d"),
        null_ls.builtins.formatting.csharpier,
      },
    })

    -- Format buffer
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
