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
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", {})
      require("neo-tree").setup({
        filesystem = {
          enable_refresh_on_write = true,
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
            hijack_netrw_behavior = "open_current",
          },
        },
        sources = { "filesystem", "git_status", "buffers" },
        source_selector = {
          winbar = true,
          content_layout = "center",
          sources = {
            { source = "filesystem", display_name = " File" },
            { source = "git_status", display_name = "󰊢 Git" },
            { source = "buffers", display_name = " Bufs" },
          },
        },
        event_handlers = {
          {
            event = "neo_tree_buffer_leave",
            handler = function()
              vim.opt_local.signcolumn = "auto:9"
            end,
          },
        },
      })
    end,
  },
}
