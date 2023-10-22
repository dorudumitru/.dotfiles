local wezterm = require("wezterm")
local onedark = wezterm.color.get_builtin_schemes()["OneDark (base16)"]
onedark.cursor_bg = "#61afef"
onedark.cursor_fg = "#282c34"

return {
	color_schemes = {
		["OneDark"] = onedark,
	},
	color_scheme = "OneDark",
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
	}),
	font_size = 13.5,
	line_height = 1.1,
	window_decorations = "RESIZE",
	use_fancy_tab_bar = false,
	initial_cols = 110,
	initial_rows = 25,
	keys = {
		{
			key = "H",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "L",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
}
