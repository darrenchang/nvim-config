return {
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'famiu/bufdelete.nvim',
    },
    commander = {
      {
        cmd = function()
          require('bufdelete').bufdelete()
        end,
        desc = 'Close buffer',
        keys = { 'n', '<leader>bd' },
      },
      {
        cmd = '<CMD>silent %bd|e#|bd#<CR>',
        desc = 'Close all other buffers',
      },
      {
        cmd = '<CMD>BufferLineCycleNext<CR>',
        desc = 'Buffer next',
        keys = { 'n', '<Tab>' },
      },
      {
        cmd = '<CMD>BufferLineCyclePrev<CR>',
        desc = 'Buffer previous',
        keys = { 'n', '<S-Tab>' },
      },
    },
    config = function()
      local bufferline = require('bufferline')
      local bufdelete = require('bufdelete')
      bufferline.setup({
        options = {
          mode = 'buffers',
          -- Prevent buffer window from being closed https://github.com/LunarVim/LunarVim/issues/2455#issuecomment-1867969796
          close_command = bufdelete.bufdelete,
          separator_style = 'slant',
          offsets = {
            {
              filetype = 'neo-tree',
              text = 'File Explorer',
              text_align = 'left',
              separator = true,
            },
          },
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(_, _, diagnostics_dict)
            local s = ''
            for e, n in pairs(diagnostics_dict) do
              local sym = e == 'error' and ' '
                  or (e == 'warning' and ' ' or '')
              if s ~= '' then
                s = ' | ' .. s
              end
              s = sym .. n .. s
            end
            return s
          end,
          always_show_bufferline = true,
        },
      })
    end,
  },
}
