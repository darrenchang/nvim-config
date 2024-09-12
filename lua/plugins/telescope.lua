return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
    },
    commander = {
      {
        cmd = "<CMD>Telescope find_files<CR>",
        desc = "Find files",
        keys = { 'n', '<leader>ff' },
      },
      {
        cmd = "<CMD>Telescope live_grep<CR>",
        desc = "Live grep",
        keys = { 'n', '<leader>fg' },
      },
      {
        cmd = "<CMD>Telescope buffers<CR>",
        desc = "Find buffers",
        keys = { 'n', '<leader>fb' },
      },
      {
        cmd = "<CMD>Telescope help_tags<CR>",
        desc = "Find available help tags",
        keys = { 'n', '<leader>fh' },
      },
    },
    config = function()
      require('telescope.builtin')
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require('telescope').setup({
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            file_ignore_patterns = { 'node_modules', '.git', 'dist' }
          },
          grep_string = {
            additional_args = {"--hidden"},
            file_ignore_patterns = { 'node_modules', '.git', 'dist' }
          },
          live_grep = {
            additional_args = {"--hidden"},
            file_ignore_patterns = { 'node_modules', '.git', 'dist' }
          },
        },
      })
      require('telescope').load_extension('ui-select')
    end,
  },
}
