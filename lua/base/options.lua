-- TODO: add more options

local options = {
	number = true,
	shiftwidth = 2,
	tabstop = 2,
	smartindent = true,
	undofile = true,
	clipboard = "unnamedplus",
	mouse = "a",
	signcolumn = "yes",
	cursorline = true,
	wrap = false,
	swapfile = false,
	termguicolors = true,
	splitright = true,
	splitbelow = true,
	fillchars = "eob: ",
	showtabline = 2,
	showbreak = "↳ ",
	fileencoding = "utf-8",
	smartcase = true,
	backup = false,
	scrolloff = 6,
	sidescroll = 6,
	sidescrolloff = 6,
	updatetime = 300,
	showmode = false,
	guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon120",
}

-- vim.opt.shortmess:append "c"

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
