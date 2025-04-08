return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      default = { "lsp", "easy-dotnet", "path", "snippets", "buffer" },
      providers = {
        ["easy-dotnet"] = {
          name = "easy-dotnet",
          enabled = true,
          module = "easy-dotnet.completion.blink",
          score_offset = 10000,
          async = true,
        },
      },
    },
  },
}
