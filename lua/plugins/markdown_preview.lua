return {
  "iamcco/markdown-preview.nvim",
  commander = {
    {
      cmd = '<CMD>MarkdownPreviewToggle<CR>',
      desc = 'Open markdown preview',
      keys = { 'n', '<leader>mp' },
      cat = 'markdown-preview',
    },
  },
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  ft = { "markdown" },
}
