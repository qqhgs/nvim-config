local indent_blankline = require "indent_blankline"
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
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
  }
end

M.setup = function()
  indent_blankline.setup(Ryn.builtins.indentline)
end

return M
