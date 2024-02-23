return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  vim.cmd("nnoremap <leader>u :UndotreeToggle<CR>"),

  -- persistent undo
  vim.cmd("set undofile"),
  vim.cmd("set undodir=~/.vim/undodir"),
  vim.cmd("set undolevels=1000"),
  vim.cmd("set undoreload=10000"),
}
