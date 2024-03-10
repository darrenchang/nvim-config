return {
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
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({
        mappings = {
          '<C-u>',
          '<C-d>',
          '<C-b>',
          '<C-f>',
          '<C-y>',
          '<C-e>',
          'zt',
          'zz',
          'zb',
        },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = "quadratic",
        pre_hook = nil,
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = false, -- Disable "Performance Mode" on all buffers.
      })
    end,
  },
}
