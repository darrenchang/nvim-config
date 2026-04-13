return {
  {
    -- https://github.com/catppuccin/nvim
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = 'dark',
          percentage = 0.15,
        },
        float = {
          transparent = false, -- enable transparent floating windows
          solid = false, -- use solid styling for floating windows, see |winborder|
        },
        custom_highlights = function(colors)
          return {
            WinSeparator = { fg = colors.surface1, bg = colors.base },
            StatusLine   = { bg = colors.base },
            StatusLineNC = { bg = colors.base },
          }
        end,
      })
      vim.cmd.colorscheme('catppuccin-mocha')
    end,
  },
}
