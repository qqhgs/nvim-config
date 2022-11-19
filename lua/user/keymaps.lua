local M = {}

local keymaps = {
  normal_mode = {
    -- Resize window with arrows
    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>",

    -- Navigate buffers
    ["<S-l>"] = ":bnext<CR>",
    ["<S-h>"] = ":bprev<CR>",
    ["<Tab>"] = ":bnext<CR>",
    ["<S-Tab>"] = ":bprev<CR>",

    -- Move current line / block with Alt-j/k like vscode.
    ["<A-k>"] = ":m .-2<CR>==",
    ["<A-j>"] = ":m .+1<CR>==",

    -- No highlight
    ["<ESC>"] = ":nohlsearch<CR>",

    -- I never use macros and more often mis-hit this key
    ["q"] = "<Nop>",

    -- I never use Ex-mode too
    -- ["Q"] = "<Nop>",
    ["gQ"] = "<Nop>",
  },
  insert_mode = {
    -- Move current line / block with Alt-j/k like vscode.
    ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
    ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
  },
  term_mode = {
    -- Terminal window navigation
    -- ["<C-h>"] = "<C-\\><C-N><C-w>h",
    -- ["<C-j>"] = "<C-\\><C-N><C-w>j",
    -- ["<C-k>"] = "<C-\\><C-N><C-w>k",
    -- ["<C-l>"] = "<C-\\><C-N><C-w>l",
  },
  visual_mode = {
    -- Indent
    ["<"] = "<gv",
    [">"] = ">gv",

    -- Move selected line / block of text
    ["<A-k>"] = ":move '<-2<CR>gv-gv",
    ["<A-j>"] = ":move '>+1<CR>gv-gv",

    -- don't yank when put on visual mode
    ["p"] = '"_dP',
  },
  visual_block_mode = {
    ["<A-k>"] = ":move '<-2<CR>gv-gv",
    ["<A-j>"] = ":move '>+1<CR>gv-gv",
  },
  command_mode = {
    -- Navigation
    ["<C-o>"] = { "<CR>", { noremap = true } },
  },
}

local adapters = {
  normal_mode = "n",
  insert_mode = "i",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
}

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  term_mode = { silent = true },
}

local function set_keymaps(mode, key, val)
  local opt = generic_opts[mode] or generic_opts_any
  if type(val) == "table" then
    opt = val[2]
    val = val[1]
  end
  if val then
    vim.keymap.set(mode, key, val, opt)
  else
    pcall(vim.api.nvim_del_keymap, mode, key)
  end
end

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", generic_opts_any)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

for mode, mapping in pairs(keymaps) do
  mode = adapters[mode]
  for k, v in pairs(mapping) do
    set_keymaps(mode, k, v)
  end
end

function M.set(mode, key, val)
  local opt = generic_opts[mode] or generic_opts_any
  if type(val) == "table" then
    opt = val[2]
    val = val[1]
  end
  if val then
    vim.keymap.set(mode, key, val, opt)
  else
    pcall(vim.api.nvim_del_keymap, mode, key)
  end
end

return M
