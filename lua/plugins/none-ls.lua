return {
  {
    'jay-babu/mason-null-ls.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
    config = function()
      require('mason-null-ls').setup({
        ensure_installed = {
          'stylua',
          'selene',
          'cbfmt',
          'black',
          'ruff',
          'isort',
          'prettier',
        },
        automatic_installation = true,
        handlers = {},
      })
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    lazy = false,
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black.with({
            extra_args = { '--line-length=120' },
          }),
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.cbfmt,
          -- null_ls.builtins.diagnostics.selene,
          -- null_ls.builtins.diagnostics.tsc,
        },
      })
    end,
  },
}
