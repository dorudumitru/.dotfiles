return {
	"hrsh7th/nvim-cmp",
	opts = function(_, opts)
		local cmp = require("cmp")
		opts.preselect = cmp.PreselectMode.None
	end,
}
