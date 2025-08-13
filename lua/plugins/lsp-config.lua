local function getHomeDirectory()
  local home = os.getenv('HOME') or os.getenv('USERPROFILE')
  return home
end

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
        ensure_installed = {
          'lua_ls',
          'ts_ls',
          'marksman',
          'pylsp',
          'vtsls',
          'vue_ls',
          'vuels',
        },
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
          vim.diagnostic.open_float()
        end,
        desc = 'View diagnostic for the current line',
        keys = { { 'n', 'v' }, '<leader>cv' },
      },
      {
        cmd = function()
          vim.diagnostic.config({ virtual_text = true })
        end,
        desc = 'Enable diagnostic virtual text',
      },
      {
        cmd = function()
          vim.diagnostic.config({ virtual_text = false })
        end,
        desc = 'Disable diagnostic virtual text',
      },
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig_util = require('lspconfig.util')
      local function on_new_config(new_config, new_root_dir)
        local function get_typescript_server_path(root_dir)
          local project_root =
            lspconfig_util.find_node_modules_ancestor(root_dir)
          return project_root
              and (lspconfig_util.path.join(
                project_root,
                'node_modules',
                'typescript',
                'lib'
              ))
            or ''
        end

        if
          new_config.init_options
          and new_config.init_options.typescript
          and new_config.init_options.typescript.tsdk == ''
        then
          new_config.init_options.typescript.tsdk =
            get_typescript_server_path(new_root_dir)
        end
      end

      local volar_cmd = { 'vue-language-server', '--stdio' }
      local volar_root_dir = lspconfig_util.root_pattern('package.json')

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
      vim.lsp.enable('lua_ls')
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        handlers = handlers,
      })
      vim.lsp.enable('ts_ls')
      vim.lsp.config('ts_ls', {
        capabilities = capabilities,
        handlers = handlers,
      })
      vim.lsp.enable('marksman')
      vim.lsp.config('marksman', {
        capabilities = capabilities,
        handlers = handlers,
      })
      vim.lsp.enable('pylsp')
      vim.lsp.config('pylsp', {
        capabilities = capabilities,
        handlers = handlers,
        settings = {
          ['pylsp'] = {
            plugins = {
              pycodestyle = {
                maxLineLength = 119,
              },
            },
          },
        },
      })
      vim.lsp.enable('vtsls')
      vim.lsp.config('vtsls', {
        filetypes = {
          'typescript',
          'javascript',
          'javascriptreact',
          'typescriptreact',
          'vue',
        },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = '@vue/typescript-plugin',
                  languages = { 'vue' },
                  configNamespace = 'typescript',
                  location = vim.fn.stdpath('data')
                    .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                },
              },
            },
          },
        },
      })
      vim.lsp.enable('vue_ls')
      vim.lsp.config('vue_ls', {
        on_init = function(client)
          client.handlers['tsserver/request'] = function(_, result, context)
            local clients =
              vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
            if #clients == 0 then
              vim.notify(
                'Could not found `vtsls` lsp client, vue_lsp would not work without it.',
                vim.log.levels.ERROR
              )
              return
            end
            local ts_client = clients[1]
            local param = unpack(result)
            local id, command, payload = unpack(param)
            ts_client:exec_cmd({
              title = 'vue_request_forward',
              command = 'typescript.tsserverRequest',
              arguments = {
                command,
                payload,
              },
            }, { bufnr = context.bufnr }, function(_, r)
              local response_data = { { id, r.body } }
              ---@diagnostic disable-next-line: param-type-mismatch
              client:notify('tsserver/response', response_data)
            end)
          end
        end,
      })
      -- set up lsp options
      vim.diagnostic.config({ virtual_text = true })
    end,
  },
}
