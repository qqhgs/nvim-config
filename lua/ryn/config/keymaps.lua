local M = {}

local defaults = {
  normal_mode = {
    -- Window navigation
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",

    -- Resize window with arrows
    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>",

    -- Navigate buffers
    ["<S-l>"] = ":bnext<CR>",
    ["<S-h>"] = ":bprev<CR>",
    -- ["<Tab>"] = ":bnext<CR>",
    -- ["<S-Tab>"] = ":bprev<CR>",

    -- Telescope find_files
    ["<C-p>"] = "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",

    -- Move current line / block with Alt-j/k like vscode.
    ["<A-k>"] = ":m .-2<CR>==",
    ["<A-j>"] = ":m .+1<CR>==",

    -- No highlight
    ["<ESC>"] = ":nohlsearch<CR>",

    -- Force write
    ["<C-s>"] = { ":w!<CR>", { silent = false } },

    -- Split
    ["|"] = { [[!v:count ? "<C-W>v<C-W><Right>" : '|']], { noremap = true, expr = true, silent = true } },
    ["_"] = { [[!v:count ? "<C-W>s<C-W><Down>"  : '_']], { noremap = true, expr = true, silent = true } },

    -- explorer
    ["<C-n>"] = ":NvimTreeToggle<CR>",

    --[[ KEYMAPS WITH LEADER ]]
    -- Comment
    ["<Leader>/"] = ':lua require("Comment.api").toggle_current_linewise()<CR>',
    -- Kill buffer
    ["<Leader>c"] = ":BufferKill<CR>", -- Delete current buffer, without delete window
    -- File explorer (Nvimtree)
    ["<Leader>e"] = ":NvimTreeToggle<CR>",
    -- Find file
    ["<Leader>f"] = ":Telescope find_files<CR>",
    -- No highlight
    ["<Leader>h"] = ":nohlsearch<CR>",

    -- Buffers
    -- Buffer list
    ["<Leader>bf"] = ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
    -- Buffer pick
    ["<Leader>bp"] = ":BufferLinePick<CR>",
    -- Buffer pick close
    ["<Leader>bc"] = ":BufferLinePickClose<CR>",

    -- Packer sync
    ["<Leader>ps"] = ":PackerSync<CR>",
  },
  insert_mode = {
    -- Move current line / block with Alt-j/k like vscode.
    ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
    ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
  },
  term_mode = {
    -- Terminal window navigation
    ["<C-h>"] = "<C-\\><C-N><C-w>h",
    ["<C-j>"] = "<C-\\><C-N><C-w>j",
    ["<C-k>"] = "<C-\\><C-N><C-w>k",
    ["<C-l>"] = "<C-\\><C-N><C-w>l",
  },
  visual_mode = {
    -- Indent
    ["<"] = "<gv",
    [">"] = ">gv",

    -- Move line up/down
    ["<A-j>"] = ":m .+1<CR>==",
    ["<A-k>"] = ":m .-2<CR>==",

    -- don't yank when put on visual mode
    ["p"] = '"_dP',

    -- Comment
    ["<Leader>/"] = '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', -- line
    ["<Leader>b"] = '<ESC><CMD>lua require("Comment.api").toggle_blockwise_op(vim.fn.visualmode())<CR>', -- block
  },
  visual_block_mode = {
    -- Move current line / block with Alt-j/k like vscode.
    ["<A-j>"] = ":m '>+1<CR>gv-gv",
    ["<A-k>"] = ":m '<-2<CR>gv-gv",
  },
  command_mode = {
    -- Navigation
    ["<C-h>"] = { "<Left>", { noremap = true } },
    ["<C-l>"] = { "<Right>", { noremap = true } },
    ["<C-b>"] = { "<C-Left>", { noremap = true } },
    ["<C-e>"] = { "<C-Right>", { noremap = true } },
    ["<C-f>"] = { "<Home>", { noremap = true } },
    ["<C-a>"] = { "<End>", { noremap = true } },
    ["<C-d>"] = { "<BS>", { noremap = true } },
    ["<C-s>"] = { "<Del>", { noremap = true } },
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

-- Append key mappings to defaults for a given mode
-- @param keymaps The table of key mappings containing a list per mode (normal_mode, insert_mode, ..)
function M.add_keymaps(keymaps)
  for mode, mappings in pairs(keymaps) do
    for k, v in pairs(mappings) do
      Ryn.keys[mode][k] = v
    end
  end
end

-- Set key mappings individually
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param key The key of keymap
-- @param val Can be form as a mapping or tuple of mapping and user defined opt
function M.set_keymaps(mode, key, val)
  local opt = generic_opts[mode] or generic_opts_any
  if type(val) == "table" then
    opt = val[2]
    val = val[1]
  end
  if val then
    vim.api.nvim_set_keymap(mode, key, val, opt)
  else
    pcall(vim.api.nvim_del_keymap, mode, key)
  end
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
function M.load_mode(mode, keymaps)
  mode = adapters[mode] or mode
  for k, v in pairs(keymaps) do
    M.set_keymaps(mode, k, v)
  end
end

-- Load key mappings for all provided modes and set the leader key
-- @param keymaps A list of key mappings for each mode
function M.load(keymaps)
  vim.g.mapleader = (Ryn.leader == "space" and " ") or Ryn.leader

  keymaps = keymaps or {}
  for mode, mapping in pairs(keymaps) do
    M.load_mode(mode, mapping)
  end

  -- Add Packer commands because we are not load it on startup
  vim.cmd "command! PackerClean lua require 'ryn.config.packer' require('packer').clean()"
  vim.cmd "command! PackerCompile lua require 'ryn.config.packer' require('packer').compile()"
  vim.cmd "command! PackerInstall lua require 'ryn.config.packer' require('packer').install()"
  vim.cmd "command! PackerStatus lua require 'ryn.config.packer' require('packer').status()"
  vim.cmd "command! PackerSync lua require 'ryn.config.packer' require('packer').sync()"
  vim.cmd "command! PackerUpdate lua require 'ryn.config.packer' require('packer').update()"
  vim.cmd "command! PackerProfile lua require 'ryn.config.packer' require('packer').profile_output()"
end

-- Load the default keymappings
function M.load_defaults()
  M.load(M.get_defaults())
  Ryn.keys = {}
  for idx, _ in pairs(defaults) do
    Ryn.keys[idx] = {}
  end
end

-- Get the default keymappings
function M.get_defaults()
  return defaults
end

return M
