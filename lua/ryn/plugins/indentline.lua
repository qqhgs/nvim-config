local M = {}

M.config = function()
  Ryn.builtins.indentline = {
    indentLine_enabled = 1,
    char = "▏",
    filetype_exclude = {
      "alpha",
      "help",
      "terminal",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "NvimTree",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
  }
end

M.setup = function()
  require("indent_blankline").setup(Ryn.builtins.indentline)
end

return M
