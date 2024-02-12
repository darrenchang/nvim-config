return {
  {
    -- https://github.com/williamboman/mason.nvim
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    -- https://github.com/williamboman/mason-lspconfig.nvim
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" }
      })
    end
  },
  {
    -- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      vim.keymap.set('n', '<leader>b', vim.lsp.buf.hover, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    end
  }
}

