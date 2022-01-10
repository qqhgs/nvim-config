require("rynkai").setup({
	italics = {
		functions = true,
	},
})

vim.cmd([[
try
  colorscheme rynkai
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
]])
