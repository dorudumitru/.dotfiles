return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = true,
				always_show = {
					".gitignore",
					".vscode",
					".idea",
					".env",
					".env.local",
					".env.development",
					".env.production",
				},
				never_show = {
					".git",
				},
			},
		},
		window = {
			position = "current",
			mappings = {
				["Z"] = "expand_all_nodes",
			},
		},
		default_component_configs = {
			created = {
				enabled = true,
				required_width = 120,
			},
		},
		-- event_handlers = {
		-- 	{
		-- 		event = "file_opened",
		-- 		handler = function()
		-- 			require("neo-tree.command").execute({ action = "close" })
		-- 		end,
		-- 	},
		-- },
	},
}
