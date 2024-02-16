return {
  {
    -- https://github.com/kdheepak/lazygit.nvim
    "kdheepak/lazygit.nvim",
    dependenceis = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("lazygit")
    end,
  },
  {
    -- https://github.com/lewis6991/gitsigns.nvim
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsignsconfig = require("gitsigns")
      gitsignsconfig.setup({
        word_diff = true,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
          delay = 0,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      })
    end,
  },
}
