return {
  {
    -- https://github.com/akinsho/bufferline.nvim
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "famiu/bufdelete.nvim",
    },
    commander = {
      {
        cmd = function()
          require("bufdelete").bufdelete()
        end,
        desc = "Close buffer",
        keys = { "n", "<leader>bd" },
      },
      {
        cmd = "<CMD>BufferLineCycleNext<CR>",
        desc = "Buffer next",
        keys = { "n", "bn" },
      },
      {
        cmd = "<CMD>BufferLineCyclePrev<CR>",
        desc = "Buffer previous",
        keys = { "n", "bp" },
      },
    },
    config = function()
      local bufferline = require("bufferline")
      local bufdelete = require("bufdelete")
      bufferline.setup({
        options = {
          mode = "buffers",
          close_command = bufdelete.bufdelete, -- Prevent buffer window from being closed https://github.com/LunarVim/LunarVim/issues/2455#issuecomment-1867969796
          separator_style = "slant",
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            },
          },
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(_, _, diagnostics_dict)
            local s = ""
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and " " or (e == "warning" and " " or "")
              if s ~= "" then
                s = " | " .. s
              end
              s = sym .. n .. s
            end
            return s
          end,
          always_show_bufferline = true,
        },
      })
    end,
  },
}
