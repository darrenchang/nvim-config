return {
  {
    'gen740/SmoothCursor.nvim',
    config = function()
      require('smoothcursor').setup({
        type = 'default',
        cursor = 'x',
        speed = 25,
        threshold = 1,
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
