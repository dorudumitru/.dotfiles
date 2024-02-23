return {
	"echasnovski/mini.hipatterns",
	opts = function()
		local hi = require("mini.hipatterns")

		return {
			-- custom LazyVim option to enable the tailwind integration
			tailwind = {
				enabled = true,
				ft = { "typescriptreact", "javascriptreact", "css", "javascript", "typescript", "html", "pcss" },
				-- full: the whole css class will be highlighted
				-- compact: only the color will be highlighted
				style = "full",
			},
			highlighters = {
				hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
				hsl_color = {
					pattern = "hsl%(%d*%.?%d+,? %d*%.?%d+%%,? %d*%.?%d+%%%)",
					group = function(_, match)
						local util = require("util.color")
						local h, s, l = match:match("hsl%((%d*%.?%d+),? (%d*%.?%d+)%%,? (%d*%.?%d+)%%%)")
						h, s, l = tonumber(h), tonumber(s), tonumber(l)
						local hex_color = util.hslToHex(h, s, l)
						return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
					end,
				},
				hsla_color = {
					pattern = "hsl%(%d*%.?%d+,? %d*%.?%d+%%,? %d*%.?%d+%%%,? %d*%.?%d+%)",
					group = function(_, match)
						local util = require("util.color")
						local h, s, l = match:match("hsl%((%d*%.?%d+),? (%d*%.?%d+)%%,? (%d*%.?%d+)%%%,? (%d*%.?%d+%))")
						h, s, l = tonumber(h), tonumber(s), tonumber(l)
						local hex_color = util.hslToHex(h, s, l)
						return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
					end,
				},
			},
		}
	end,
}
