local default_options = {

  -- showtabline = 2,
  backup = false, -- create backup files
  writebackup = false,
  breakindent = true,
  clipboard = "unnamedplus", -- allow neovim to access system clipboard
  cmdheight = 0, -- space in the neovim command line
  colorcolumn = { "+1" }, -- draw a vertical ruler at (textwidth + 1)th column
  conceallevel = 2, -- hide concealed text unless it has a custom replacement
  confirm = true,
  cursorline = true, -- highlight current line
  expandtab = true,
  fileencoding = "utf-8", -- the encoding written to a file
  guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon120",
  ignorecase = true, -- use case-insensitive in search
  laststatus = 3, -- use global status line
  -- list = true,
  mouse = "", -- ignore mouse
  -- number = true,
  -- pumblend = 4, -- pseudo-transparency for the popup-menu, value: 0 - 100
  -- relativenumber = true,
  ruler = false,
  scrolloff = 6,
  -- shell = "/usr/bin/bash",
  shiftwidth = 0,
  showbreak = "↳ ",
  synmaxcol = 120,
  showmatch = true,
  showmode = false,
  pumheight = 10,
  sidescroll = 6,
  sidescrolloff = 6,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  softtabstop = -1,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 2,
  termguicolors = true,
  undofile = true,
  updatetime = 300,
  timeoutlen = 500,
  visualbell = true,
  wrap = false,
  wildmode = { "longest", "full" },
}

if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.opt.shortmess:append({ C = true })
end

vim.opt.wildoptions:remove({ "tagfile" })
vim.opt.listchars:append({
  -- tab = "│ ",
})

vim.opt.spelllang:append("cjk")

vim.opt.complete:remove({
  -- disable scan for
  "u", -- unload buffers
  "t", -- tab completion
})

vim.opt.nrformats:append({ "alpha" }) -- increment/decrement for alphabet

vim.opt.completeopt:append({
  "menuone", -- use the popup menu also when there is only one match
  "noinsert", -- do not insert any text for amatch until the user selects a match from the menu
})

vim.opt.fillchars:append({
  eob = " ",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
  foldopen = "",
  foldclose = "",
  diff = "/",
})

vim.opt.shortmess:append({
  c = true,
  I = true,
})

vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

for k, v in pairs(default_options) do
  vim.opt[k] = v
end

if vim.g.colors_name == nil then vim.cmd([[colorscheme habamax]]) end
