return {
  {
    -- https://github.com/nvimtools/none-ls.nvim
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.cbfmt,
          -- null_ls.builtins.diagnostics.selene,
          null_ls.builtins.diagnostics.ruff,
          null_ls.builtins.diagnostics.eslint_d,
        },
      })
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },
  {
    -- https://github.com/jay-babu/mason-null-ls.nvim
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "stylua", "selene", "cbfmt", "black", "isort", "ruff", "prettier", "eslint_d" },
      })
    end,
  },
}
