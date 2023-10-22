return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = function()
				require("onedark").setup({
					code_style = {
						comments = "italic",
						keywords = "italic",
						functions = "bold",
						strings = "none",
						variables = "none",
					},
					highlights = {
						-- italic html attributes
						["@tag.attribute"] = { fmt = "italic" },
					},
				})
				require("onedark").load()
			end,
		},
	},
	{
		{
			"nvim-treesitter/nvim-treesitter",
			opts = function(_, opts)
				vim.list_extend(opts.ensure_installed, {
					"svelte",
				})
			end,
		},
	},
	{
		{
			"nvim-neo-tree/neo-tree.nvim",
			opts = {
				filesystem = {
					filtered_items = {
						hide_dotfiles = false,
						never_show = {
							".DS_Store",
							".git",
						},
					},
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
}
