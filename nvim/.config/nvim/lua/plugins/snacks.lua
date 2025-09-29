-- lazy.nvim
return {
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {
        configure = false,
      },
      picker = {
        sources = {
          explorer = {
            auto_close = true,
            hidden = true,
            ignored = true,
            exclude = { "node_modules", ".git", ".next" },
          },
        },
      },
    },
  },
}
