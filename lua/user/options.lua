local default_options = {
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
  laststatus = 3,
	cmdheight = 0,
}

vim.opt.fillchars:append {
  eob = " ",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
}

for k, v in pairs(default_options) do
  vim.opt[k] = v
end

-- vim.opt.shortmess:append "c"

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[colorscheme habamax]]
vim.cmd [[set iskeyword+=-]]
