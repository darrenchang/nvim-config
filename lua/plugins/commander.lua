return {
  "FeiyouG/commander.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local commander = require("commander")
    commander.add({
      {
        desc = "Open Telescope commander menu",
        cmd = "<CMD>Telescope commander<CR>",
        keys = {
          { 'n', "<leader>f"},
          { "n", "<C-p>" },
        },
        show = false,
      },
    })
    commander.setup({
      prompt_title = "Commander",
      separator = "  ",
      components = {
        "DESC",
        "KEYS",
        "CAT",
        "CMD",
      },
      sort_by = {
        "DESC",
        "KEYS",
        "CAT",
        "CMD",
      },
      integration = {
        telescope = {
          enable = true,
        },
        lazy = {
          enable = true,
          set_plugin_name_as_cat = true,
        },
      },
    })
  end,
}
