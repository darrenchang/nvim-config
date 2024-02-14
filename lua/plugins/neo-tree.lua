return {
  {
    -- https://github.com/nvim-neo-tree/neo-tree.nvim
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal left<CR>", {})
      require("neo-tree").setup({
        filesystem = {
          enable_refresh_on_write = true,
          use_libuv_file_watcher = true,
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },

        },
      })
    end,
  },
}
