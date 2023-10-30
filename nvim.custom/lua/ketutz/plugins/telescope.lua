return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 
        { 'nvim-lua/plenary.nvim' }, 
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { 'nvim-tree/nvim-web-devicons' }, 
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require('telescope.builtin')

        telescope.setup({
            defaults = {
                path_display = { "truncate " },
                prompt_prefix = " ",
                selection_caret = "❯ ",
                entry_prefix = "  ",
            },
            extensions = {
                fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            }
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find string in cwd" })
        keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Find string under cursor in cwd" })
        keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Fuzzy find recent files" })
        keymap.set("n", "<leader>fh", builtin.help_tags, {})
    end,
}
