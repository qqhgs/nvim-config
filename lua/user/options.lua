local default_options = {
    -- showtabline = 2,
    backup = false, -- create backup files
    writebackup = true,
    breakindent = true,
    clipboard = "unnamedplus", -- allow neovim to access system clipboard
    cmdheight = 0, -- space in the neovim command line
    colorcolumn = { "+1" }, -- draw a vertical ruler at (textwidth + 1)th column
    conceallevel = 2, -- hide concealed text unless it hasi a custom replacement
    confirm = true,
    cursorline = true, -- highlight current line
    expandtab = true,
    fileencoding = "utf-8", -- the encoding written to a file
    guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon120",
    ignorecase = true, -- use case-insensitive in search
    laststatus = 3, -- use global status line
    list = true,
    mouse = "", -- ignore mouse
    number = true,
    pumblend = 4, -- pseudo-transparency for the popup-menu, value: 0 - 100
    relativenumber = true,
    ruler = false,
    scrolloff = 6,
    shell = "/usr/bin/bash",
    shiftwidth = 0,
    showbreak = "↳ ",
    showcmd = false,
    splitkeep = "topline",
    synmaxcol = 120,
    showmatch = true,
    showmode = false,
    sidescroll = 6,
    sidescrolloff = 6,
    signcolumn = "no",
    smartcase = true,
    smartindent = true,
    softtabstop = -1,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 4,
    termguicolors = true,
    undofile = true,
    updatetime = 300,
    undolevels = 100,
    visualbell = true,
    wrap = false,
    wildmode = { "longest", "full" }
}

vim.opt.wildoptions:remove({ "tagfile" })
vim.opt.listchars:append({
    tab = "│ ",
})

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

vim.opt.shortmess = { -- shorten message in prompt window
    a = true, -- enable 'filmnrwx' flag
    t = true, -- truncate file message at the start
    T = true, -- truncate other messages in the middle
    c = true, -- don't give ins-completion-menu messages
    F = true, -- don't give the file info when editing a file
}

for k, v in pairs(default_options) do
    vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
