return {
	"nvim-treesitter/nvim-treesitter",
	opts = function(_, opts)
		vim.list_extend(opts.ensure_installed, {
			"bash",
			"css",
			"csv",
			"dockerfile",
			"git_config",
			"git_rebase",
			"gitcommit",
			"gitignore",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"html",
			"javascript",
			"json",
			"lua",
			"make",
			"markdown",
			"proto",
			"regex",
			"rust",
			"scss",
			"sql",
			"svelte",
			"tmux",
			"toml",
			"tsx",
			"typescript",
			"xml",
			"yaml",
		})
	end,
}
