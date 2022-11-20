local present, indentline = pcall(require, "indent_blankline")
if not present then
	return
end

local configs = {
  char = "▏",
  filetype_exclude = {
    "alpha",
    "help",
    "terminal",
    "packer",
    "lspinfo",
    "TelescopePrompt",
		"lsp-installer",
    "TelescopeResults",
		"neo-tree",
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
	-- use_treesitter = true,
	-- show_current_context = true,
	-- show_current_context_start = true,
	-- max_indent_increase = 1,
	-- context_patterns = {
	-- 	"table",
	-- 	"dictionary",
	-- 	"list",
	-- 	"array",
	-- 	"object",
	-- 	"class",
	-- 	"function",
	-- 	"method",
	-- 	"parameters",
	-- 	"expression_list",
	-- 	"for_statement",
	-- 	"if",
	-- }
}
indentline.setup(configs)
