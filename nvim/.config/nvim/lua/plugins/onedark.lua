return {
  {
    "navarasu/onedark.nvim",
    opts = {
      code_style = {
        comments = "italic",
        keywords = "italic",
        functions = "bold",
        strings = "none",
        variables = "none",
      },
      highlights = {
        ["@type.qualifier"] = { fg = "$purple", fmt = "italic" },
        ["@tag.attribute"] = { fmt = "italic" },
        ["@tag.delimiter"] = { fg = "#848b98" },
      },
    },
  },
}
