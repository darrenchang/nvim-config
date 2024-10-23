return {
  'FeiyouG/commander.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local commander = require('commander')
    commander.add({
      {
        desc = 'Open Telescope commander menu',
        cmd = '<CMD>Telescope commander<CR>',
        keys = {
          { 'n', '<C-p>' },
        },
        show = false,
      },
      {
        desc = 'Run restart api script',
        cmd = '<CMD>wa<CR><CMD>silent !./restart_api.sh<CR>',
      },
      {
        desc = 'Copy the nvim buffer to tmux buffer',
        cmd = "<CMD>'<,'>w !tmux load-buffer -<CR>",
      },
      {
        cmd = function()
          local bufnr = vim.api.nvim_get_current_buf()
          vim.cmd('bdelete! ' .. bufnr)
        end,
        desc = 'Close buffer',
        keys = { 'n', '<leader>bd' },
      },
      {
        cmd = function()
          local bufs_to_delete = {}
          -- Collect all buffers that need to be deleted
          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if
              vim.fn.bufwinnr(bufnr) == -1
              and vim.api.nvim_buf_get_option(bufnr, 'buflisted')
            then
              table.insert(bufs_to_delete, bufnr)
            end
          end
          -- Delete the collected buffers
          for _, bufnr in ipairs(bufs_to_delete) do
            vim.cmd('bdelete! ' .. bufnr)
          end
        end,
        desc = 'Close all buffers that are not in the current window',
      },
    })
    commander.setup({
      prompt_title = 'Commander',
      separator = ' │ ',
      components = {
        'DESC',
        'KEYS',
        'CAT',
        'CMD',
      },
      sort_by = {
        'CAT',
        'KEYS',
        'DESC',
        'CMD',
      },
      integration = {
        telescope = {
          enable = true,
        },
        lazy = {
          enable = true,
          set_plugin_name_as_cat = true,
        },
      },
    })
  end,
}
