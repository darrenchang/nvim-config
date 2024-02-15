return {
	{
		-- https://github.com/akinsho/bufferline.nvim
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local bufferline = require("bufferline")
			bufferline.setup({
				options = {
					mode = "buffers",
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
							s = sym .. n .. "|" .. s
						end
						return s
					end,
				},
			})
		end,
	},
}
