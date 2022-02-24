require("rynkai").setup {
	theme = "catppuccin", -- this field is a must.
	config_file = "lua/ryn/plugins/colorscheme.lua", -- this field is a must.
	rynkai_dir = "/site/pack/packer/opt/rynkai.nvim/lua/rynkai/colors/", -- this field is a must.
}

vim.cmd [[ colorscheme rynkai ]]

require("telescope").load_extension "rynkai"

vim.api.nvim_set_keymap(
	"n",
	"<Leader>st",
	":Telescope rynkai<CR>",
	{ noremap = true, silent = true }
)
