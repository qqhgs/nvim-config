local ready, indent_blankline = pcall(require, "indent_blankline")
if not ready then
	return
end

indent_blankline.setup({
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
})
