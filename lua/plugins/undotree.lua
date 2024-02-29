return {
  'mbbill/undotree',
  commander = {
    {
      cmd = '<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>',
      desc = 'Toggle undotree',
      keys = { 'n', '<leader>u' },
      cat = 'undotree',
    },
  },
  config = function()
    -- persistent undo
    vim.cmd 'set undofile'
    vim.cmd 'set undodir=~/.vim/undodir'
    vim.cmd 'set undolevels=1000'
    vim.cmd 'set undoreload=10000'
  end,
}
