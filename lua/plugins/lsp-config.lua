return {
  {
    -- https://github.com/williamboman/mason.nvim
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    -- https://github.com/williamboman/mason-lspconfig.nvim
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "marksman", "pylsp" },
      })
    end,
  },
  {
    -- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      -- set up lsp servers
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })
      lspconfig.marksman.setup({
        capabilities = capabilities,
      })
      lspconfig.pylsp.setup({
        capabilities = capabilities,
      })
      -- set up keybindings
      vim.keymap.set("n", "<leader>b", vim.lsp.buf.hover, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    end,
  },
}
