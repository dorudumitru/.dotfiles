return {
  'navarasu/onedark.nvim',
  config = function()
    require("onedark").setup({
        code_style = {
            comments = "italic",
            keywords = "italic",
            functions = "none",
            strings = "none",
            variables = "none",
        },
    })
    require("onedark").load()
  end
}
