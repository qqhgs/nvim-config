local Util = require("util")

local function map(mode, key, val, opt)
  local options = { noremap = true, silent = true }
  if opt ~= nil then options = vim.tbl_deep_extend("force", options, opt) end
  if val then
    vim.keymap.set(mode, key, val, options)
  else
    pcall(vim.api.nvim_del_keymap, mode, key)
  end
end

map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

map("n", "gw", "*N")
map("x", "gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- open
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" }) end

-- Prevent entering Ex-mode
map("n", "Q", "<Nop>")
map("n", "gQ", "<Nop>")

-- Copy/paste with system clipboard
map({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
map("n", "gp", '"+p', { desc = "Paste from system clipboard" })
-- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
map("x", "gp", '"+P', { desc = "Paste from system clipboard" })

-- Move only sideways in command mode. Using `silent = false` makes movements
-- to be immediately shown.
map("c", "<M-h>", "<Left>", { silent = false, desc = "Left" })
map("c", "<M-l>", "<Right>", { silent = false, desc = "Right" })

-- Window navigation
map("n", "<C-H>", "<C-w>h", { desc = "Focus on left window" })
map("n", "<C-J>", "<C-w>j", { desc = "Focus on below window" })
map("n", "<C-K>", "<C-w>k", { desc = "Focus on above window" })
map("n", "<C-L>", "<C-w>l", { desc = "Focus on right window" })

-- Add empty lines before and after cursor line
map("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "Put empty line above" })
map("n", "go", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>", { desc = "Put empty line below" })

-- Alternative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
map("n", "<C-S>", "<Cmd>silent! update | redraw<CR>", { desc = "Save" })
map({ "i", "x" }, "<C-S>", "<Esc><Cmd>silent! update | redraw<CR>", { desc = "Save and go to Normal mode" })

-- buffers
map("n", "<leader>bd", "<cmd>BufferKill<cr>", { desc = "Close" })
map("n", "<leader>bD", "<cmd>bd!<cr>", { desc = "Close (!)" })
map("n", "<leader>bx", "<cmd>%bd<cr>", { desc = "Close all" })
map("n", "<leader>bc", "<cmd>lua require('util.buffer').other()<cr>", { desc = "Close other" })
map("n", "<leader>bw", function() require("util.buffer").kill_buffer("bw") end, { desc = "Wipeout" })

-- toggle options
map("n", "<leader>tf", function() require("plugins.lsp.format").toggle() end, { desc = "Toggle format on Save" })
map("n", "<leader>ts", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>tr", function() Util.toggle("cursorline") end, { desc = "Toggle Cursorline" })
map("n", "<leader>tw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>tn", function() Util.toggle("number") end, { desc = "Toggle Number" })
map("n", "<leader>td", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map(
  "n",
  "<leader>tc",
  function() Util.toggle("conceallevel", false, { 0, conceallevel }) end,
  { desc = "Toggle Conceal" }
)

-- tabs
map("n", "<leader>il", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader>if", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader>in", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader>i]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader>id", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader>i[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
