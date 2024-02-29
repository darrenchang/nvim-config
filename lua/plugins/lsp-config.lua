return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'tsserver', 'marksman', 'pylsp' },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    commander = {
      {
        cmd = function()
          vim.lsp.buf.code_action(opts)
        end,
        desc = 'Code actions',
        keys = { { 'n', 'v' }, '<leader>ca' },
      },
      {
        cmd = function()
          vim.lsp.buf.hover()
        end,
        desc = 'See buf hover',
        keys = { 'n', 'K' },
      },
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      -- Set hover window to transparent background color
      local set_hl_for_floating_window = function()
        vim.api.nvim_set_hl(0, 'NormalFloat', {
          link = 'Normal',
        })
        vim.api.nvim_set_hl(0, 'FloatBorder', {
          bg = 'none',
        })
      end

      set_hl_for_floating_window()

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        desc = 'Avoid overwritten by loading color schemes later',
        callback = set_hl_for_floating_window,
      })
      -- LSP settings (for overriding per client)
      local handlers = {
        ['textDocument/hover'] = vim.lsp.with(
          vim.lsp.handlers.hover,
          { border = 'rounded', bg = 'none' }
        ),
        ['textDocument/signatureHelp'] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { border = 'rounded', bg = 'none' }
        ),
      }
      -- set up lsp servers
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.marksman.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.pylsp.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      -- set up lsp options
      vim.lsp.handlers['textDocument/publishDiagnostics'] =
          vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            update_in_insert = true,
          })
    end,
  },
}
