local present, indentline = pcall(require, "indent_blankline")
if not present then
	return
end

local configs = {
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
		"neo-tree",
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
}
indentline.setup(configs)
