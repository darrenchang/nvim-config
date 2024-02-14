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
}
