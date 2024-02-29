return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {},
  config = function()
    require('ibl').setup {
      scope = { enabled = true },
    }
  end,
}
