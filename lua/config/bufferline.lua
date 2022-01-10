local ready, bufferline = pcall(require, "bufferline")
if not ready then
	return
end

bufferline.setup({
	options = {
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count .. " "
		end,
		separator_style = { "", "" },
		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		modified_icon = " ",
	},
})
