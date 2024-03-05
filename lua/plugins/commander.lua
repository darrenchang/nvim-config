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
          { 'n', '<leader>f' },
          { 'n', '<C-p>' },
        },
        show = false,
      },
      {
        desc = 'Run restart api script',
        cmd = '<CMD>wa<CR><CMD>!./restart_api.sh<CR>',
      },
      {
        desc = 'Copy the nvim buffer to tmux buffer',
        cmd = '<CMD>\'<,\'>w !tmux load-buffer -<CR>',
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
