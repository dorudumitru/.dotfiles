return {
	{
		"navarasu/onedark.nvim",
		opts = function()
			require("onedark").setup({
				code_style = {
					comments = "italic",
					keywords = "italic",
					functions = "bold",
					strings = "none",
					variables = "none",
				},
				highlights = {
					["@tag.attribute"] = { fmt = "italic" },
					["@tag.delimiter"] = { fg = "#848b98" },
				},
			})
		end,
	},
}
