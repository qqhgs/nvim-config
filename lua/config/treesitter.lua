local ready, configs = pcall(require, "nvim-treesitter.configs")
if not ready then
	return
end

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

configs.setup({
	ensure_installed = {
		"html",
		"css",
		"scss",
		"c",
		"go",
		"json",
		"javascript",
		"svelte",
		"php",
		"lua",
		"vim",
		"bash",
		"markdown",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	autopairs = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	indent = { enable = true },
	autotag = { enable = true },
	-- rainbow = { enable = true },
})
