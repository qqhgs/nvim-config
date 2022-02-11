local M = {}

M.enable_format_on_save = function()
	vim.cmd([[
		augroup format_on_save
			autocmd! 
			autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
		augroup end
		]])
	print("Enabled format on save.")
end

M.disable_format_on_save = function()
	if vim.fn.exists("#format_on_save") == 1 then
		vim.cmd("au! format_on_save")
	end
				print("Disabled ormat on save.")
end

M.toggle_format_on_save = function()
	if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
		M.enable_format_on_save()
	else
		M.disable_format_on_save()
	end
end

M.load_config = function()
   local default = require("ryn.settings.default")
   local present, user = pcall(require, "ryn.rc")
   if present then
      default = vim.tbl_deep_extend("force", default, user)
   end
   return default
end

return M
