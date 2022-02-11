local present, toggleterm = pcall(require, "toggleterm")
if not present then
	return
end

toggleterm.setup({
	open_mapping = [[<C-t>]],
	-- direction = "float",
	float_opts = {
		border = "curved",
		winblend = 5,
		highlights = {
			border = "NormalFloat",
			background = "NormalFloat",
		},
	},
})

function _G.set_terminal_keymaps()
	vim.api.nvim_buf_set_keymap(0, "t", "<C-\\>", [[<C-\><C-n><C-W>l]], { noremap = true })
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end
