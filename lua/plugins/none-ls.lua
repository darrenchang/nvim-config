return {
  {
    'nvimtools/none-ls.nvim',
    commander = {
      {
        cmd = function()
          vim.lsp.buf.format()
        end,
        desc = 'Format the buffer',
        keys = { 'n', '<leader>gf' },
      },
    },
    config = function()
      local null_ls = require 'null-ls'
      null_ls.setup {
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
      }
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
    config = function()
      require('mason-null-ls').setup {
        ensure_installed = {
          'stylua',
          'selene',
          'cbfmt',
          'black',
          'isort',
          'ruff',
          'prettier',
          'eslint_d',
        },
      }
    end,
  },
}
