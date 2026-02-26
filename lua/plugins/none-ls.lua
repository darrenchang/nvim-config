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
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black.with({
            extra_args = { '--line-length=120', '--skip-string-normalization' },
          }),
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.cbfmt,
          -- null_ls.builtins.diagnostics.selene,
          -- null_ls.builtins.diagnostics.ruff,
          -- null_ls.builtins.diagnostics.tsc,
        },
      })
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
    config = function()
      local registry = require('mason-registry')
      local platform = require('mason-core.platform')

      local function is_platform_supported(pkg_name)
        local ok, pkg = pcall(registry.get_package, pkg_name)
        if not ok then return false end
        local spec = pkg.spec
        if not (spec and spec.source and spec.source.asset) then return true end
        local asset = spec.source.asset
        if type(asset) ~= 'table' or not (asset[1] and asset[1].target) then
          return true
        end
        for _, a in ipairs(asset) do
          local targets = type(a.target) == 'string' and { a.target } or a.target
          if type(targets) == 'table' then
            for _, t in ipairs(targets) do
              if platform.is[t] then return true end
            end
          end
        end
        return false
      end

      local wanted = {
        'stylua',
        'selene',
        'cbfmt',
        'black',
        'isort',
        'ruff',
        'prettier',
      }

      require('mason-null-ls').setup({
        ensure_installed = vim.tbl_filter(is_platform_supported, wanted),
      })
    end,
  },
}
