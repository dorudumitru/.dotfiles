return {
  "https://gitlab.com/schrieveslaach/sonarlint.nvim.git",
  lazy = true,
  ft = { "typescript", "javascript", "java", "cs" },
  config = function()
    require("sonarlint").setup({
      server = {
        cmd = {
          vim.fn.expand("$MASON/bin/sonarlint-language-server"),
          "-stdio",
          "-analyzers",
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
          vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcsharp.jar"),
        },
        init_options = {
          omnisharpDirectory = vim.fn.expand("$MASON/packages/sonarlint-language-server/extension/omnisharp"),
          csharpOssPath = vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcsharp.jar"),
          csharpEnterprisePath = vim.fn.expand("$MASON/share/sonarlint-analyzers/csharpenterprise.jar"),
        },
      },
      filetypes = {
        "typescript",
        "javascript",
        "java",
        "cs",
      },
    })
  end,
}
