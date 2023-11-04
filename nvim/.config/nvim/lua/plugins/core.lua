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
		{
			"nvim-treesitter/nvim-treesitter",
			opts = function(_, opts)
				vim.list_extend(opts.ensure_installed, {
					"svelte",
					"css",
				})
			end,
		},
	},
	{
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
