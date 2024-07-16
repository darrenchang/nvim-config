return {
  {
    'kdheepak/lazygit.nvim',
    dependenceis = {
      'nvim-lua/plenary.nvim',
    },
    cmd = {
      "LazyGit",
      "LazyGitFilterCurrentFile"
    },
    commander = {
      {
        cmd = '<CMD>LazyGit<CR>',
        desc = 'Open LazyGit float window',
        keys = { 'n', '<leader>lg' },
      },
      {
        cmd = '<CMD>LazyGitFilterCurrentFile<CR>',
        desc = 'Open LazyGitFilter for the current file in a float window',
        keys = { 'n', '<leader>flg' },
      }
    },
    config = function()
      require('lazygit')
      vim.g.lazygit_use_custom_config_file_path = 1
      vim.g.lazygit_config_file_path = vim.fn.stdpath("config") .. '/extra/lazygit/config.yml'
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    commander = {
      {
        cmd = function()
          package.loaded.gitsigns.blame_line({ full = true })
        end,
        desc = 'Blame line',
        keys = { 'n', '<leader>hb' },
      },
      {
        cmd = function()
          package.loaded.gitsigns.toggle_current_line_blame()
        end,
        desc = 'Toggle current line git blame',
        keys = { 'n', '<leader>tb' },
      },
      {
        cmd = function()
          package.loaded.gitsigns.stage_hunk()
        end,
        desc = 'Stage hunk',
        keys = { 'n', '<leader>hs' },
      },
      {
        cmd = function()
          package.loaded.gitsigns.stage_hunk({
            vim.fn.line('.'),
            vim.fn.line('v'),
          })
        end,
        desc = 'Stage selected hunk',
        keys = { 'v', '<leader>hs' },
      },
      {
        cmd = function()
          package.loaded.gitsigns.stage_buffer()
        end,
        desc = 'Stage buffer',
        keys = { 'n', '<leader>hS' },
      },
      {
        cmd = function()
          package.loaded.gitsigns.undo_stage_hunk()
        end,
        desc = 'Unstage hunk',
        keys = { 'n', '<leader>hu' },
      },
      {
        cmd = function()
          package.loaded.gitsigns.preview_hunk()
        end,
        desc = 'Preview hunk',
        keys = { 'n', '<leader>hp' },
      },
      {
        cmd = function()
          package.loaded.gitsigns.toggle_deleted()
        end,
        desc = 'Toggle the deleted lines',
        keys = { 'n', '<leader>td' },
      },
      {
        cmd = function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            package.loaded.gitsigns.next_hunk()
          end)
          return '<Ignore>'
        end,
        desc = 'Next hunk',
        keys = { 'n', ']c' },
      },
      {
        cmd = function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            package.loaded.gitsigns.prev_hunk()
          end)
          return '<Ignore>'
        end,
        desc = 'Previous hunk',
        keys = { 'n', '[c' },
      },
    },
    config = function()
      local gitsignsconfig = require('gitsigns')
      gitsignsconfig.setup({
        word_diff = false,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 0,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y/%m/%d> - <summary>',
      })
    end,
  },
}
