return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  opts = {
    transparent_background = true,
    float = {
      transparent = true,
    },
    integrations = {
      rainbow_delimiters = true,
    },
    styles = {
      comments = { "italic" },
      conditionals = {},
      loops = {},
      functions = {},
      keywords = { "italic" },
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    highlight_overrides = {
      all = function(macchiato)
        return {
          ["@lsp.type.variable.rust"] = { fg = macchiato.sky }, -- interpolated variables
          ["@lsp.type.formatSpecifier.rust"] = { fg = macchiato.peach }, -- interpolated variables curly braces
          ["@lsp.type.string.go"] = {}, -- clear gopls string token (prio 125) so treesitter shows through
          ["@lsp.type.keyword.go"] = {}, -- go keyword italic
          ["@keyword.coroutine.go"] = { fg = macchiato.teal }, -- go keyword teal
        }
      end,
    },
  },
}
