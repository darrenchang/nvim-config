return {
  'iamcco/markdown-preview.nvim',
  commander = {
    {
      cmd = '<CMD>MarkdownPreview<CR>',
      desc = 'Open markdown preview',
      keys = { 'n', '<leader>mp' },
      cat = 'markdown-preview',
    },
    {
      cmd = '<CMD>MarkdownPreviewStop<CR>',
      desc = 'Close markdown preview',
      keys = { 'n', '<leader>mP' },
      cat = 'markdown-preview',
    },
  },
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  config = function()
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_open_to_the_world = 1
    vim.g.mkdp_open_ip = '127.0.0.1'
    vim.g.mkdp_port = ''
    vim.g.mkdp_browser = 'none'
    vim.g.mkdp_echo_preview_url = 1
  end,
  ft = { 'markdown' },
}
