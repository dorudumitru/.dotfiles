-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

if not vim.g.vscode then
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		pattern = { "*.go" },
		callback = function()
			local lsputil = require("lspconfig.util")
			local cwd = lsputil.root_pattern("go.mod")(vim.fn.expand("%:p"))
			local config = lsputil.root_pattern(".golangci.yaml")(vim.fn.expand("%:p"))
			local golangcilint = require("lint.linters.golangcilint")
			golangcilint.args = {
				"run",
				"--fast",
				"--out-format",
				"json",
				"--timeout",
				"5m",
			}
			if config ~= nil then
				config = config .. "/.golangci.yaml"
				table.insert(golangcilint.args, "--config")
				table.insert(golangcilint.args, config)
			end
			golangcilint.cwd = cwd
		end,
	})
end
