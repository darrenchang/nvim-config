return {
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      legacy_computing_symbols_support = true,
      cursor_color = '#00fff0',
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
      hide_target_hack = false,
    },
  },
  {
    'gen740/SmoothCursor.nvim',
    config = function()
      require('smoothcursor').setup({
        type = 'default',
        speed = 25,
        threshold = 3,
        intervals = 40,
        fancy = {
          enable = true,
          head = { cursor = '', texthl = 'SmoothCursor', linehl = nil },
          body = {
            { cursor = '', texthl = 'SmoothCursorOrange' },
          },
          tail = { cursor = nil, texthl = 'SmoothCursor' },
        },
      })
    end,
  },
}
