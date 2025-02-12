-- lazy.nvim
return {
  {
    "folke/snacks.nvim",
    opts = {
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
