-- to keep the cursor in the middle while moving and searching
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('v', 'y', function()
  vim.cmd('normal! y')
  local content = vim.fn.getreg('"')
  vim.fn.system('tmux load-buffer -', content)
end)
