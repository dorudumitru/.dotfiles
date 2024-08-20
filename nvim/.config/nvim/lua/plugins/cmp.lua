return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{ "windwp/nvim-autopairs", opts = {} },
	},
	opts = function(_, opts)
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		-- Insert parentheses after selecting method/function
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		opts.preselect = cmp.PreselectMode.None
	end,
}
