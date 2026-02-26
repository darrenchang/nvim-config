return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'lua',
        'javascript',
        'python',
        'vue',
        'typescript',
        'html',
        'css',
      },
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'vimdoc' },
      },
      indent = { enable = true },
    },
  },
}
