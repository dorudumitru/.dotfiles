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
					["@punctuation.bracket"] = { fg = "#E5C07B" },
				},
			})
		end,
	},
}
