return {
	"folke/noice.nvim",
	opts = {
		lsp = {
			hover = {
				silent = true,
			},
		},
	},
	keys = {
		{ "<c-f>", false, mode = { "i", "n", "s" } },
		{ "<c-b>", false, mode = { "i", "n", "s" } },
	},
}
