require("rynkai").setup {
	theme = "catppuccin", -- this field is a must. Don't remove it, just change the value.
}

vim.cmd [[
try
  colorscheme rynkai
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
]]

require("telescope").load_extension "themes"

vim.api.nvim_set_keymap("n", "<Leader>st", ":Telescope themes<CR>", { noremap = true, silent = true })
