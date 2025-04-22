return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local config = require('nvim-treesitter.configs')
      config.setup({
        ensure_installed = { 'lua', 'javascript', 'python', 'vue', 'typescript', 'html', 'css' },
        auto_instal = true,
        highlight = {
          enable = true,
          disable = { "vimdoc" },
        },
        indent = { enable = true },
      })
    end,
  },
}
