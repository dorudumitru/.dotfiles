return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = function()
				require("onedark").load()
			end,
		},
	},
	{
		"folke/noice.nvim",
		keys = {
			{ "<c-f>", false, mode = { "i", "n", "s" } },
			{ "<c-b>", false, mode = { "i", "n", "s" } },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"svelte",
				"css",
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"css-lsp",
				"emmet-language-server",
				"lua-language-server",
				"svelte-language-server",
			},
		},
	},
	{
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
					},
					never_show = {
						".git",
					},
				},
			},
			window = {
				mappings = {
					["Z"] = "expand_all_nodes",
				},
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.sections.lualine_z = {}
		end,
	},
	{
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
						pattern = "hsl%(%d*%.?%d+ %d*%.?%d+%% %d*%.?%d+%%%)",
						group = function(_, match)
							local util = require("util.color")
							local h, s, l = match:match("hsl%((%d*%.?%d+) (%d*%.?%d+)%% (%d*%.?%d+)%%%)")
							h, s, l = tonumber(h), tonumber(s), tonumber(l)
							local hex_color = util.hslToHex(h, s, l)
							return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
						end,
					},
				},
			}
		end,
	},
}
