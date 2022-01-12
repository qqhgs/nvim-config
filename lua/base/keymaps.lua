local keymaps = {
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
		["<Tab>"] = ":bnext<CR>",
		["<S-Tab>"] = ":bprev<CR>",

		-- Telescope find_files
		["<C-p>"] = "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",

		-- Move current line / block with Alt-j/k like vscode.
		["<A-k>"] = ":m .-2<CR>==",
		["<A-j>"] = ":m .+1<CR>==",
		["<S-j>"] = ":m .+1<CR>==",
		["<S-k>"] = ":m .-2<CR>==",

		-- I never use macros and more often mis-hit this key
		-- ["q"] = "<Nop>",

		-- I never use Ex-mode too
		["Q"] = "<Nop>",
		-- ["gQ"] = "<Nop>",

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
		--
		-- Comment line
		["<Leader>/"] = ':lua require("Comment.api").toggle_current_linewise()<CR>',
		-- Write!
		["<Leader>w"] = ":w!<CR>",
		-- Kill buffer
		["<Leader>c"] = ":b#|bd#<CR>", -- Delete current buffer, without delete window
		["<Leader>x"] = ":bdelete!<CR>", -- Delete buffer
		-- File explorer (Nvimtree)
		["<Leader>e"] = ":NvimTreeToggle<CR>",
		-- Find file
		["<Leader>f"] = "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		-- Find text
		-- ["<Leader>t"] = ":Telescope live_grep theme=ivy<CR>",
		-- No highlight search
		["<Leader>h"] = ":nohlsearch<CR>",
		-- Replace all word on cursor in buffer
		["<Leader>r"] = { ":%s/\\<<C-R><C-W>\\>\\C//g<left><left>", { noremap = true } },

		-- Buffers
		-- Buffer list
		["<Leader>bf"] = ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
		-- Buffer pick
		["<Leader>bp"] = ":BufferLinePick<CR>",
		-- Buffer pick close
		["<Leader>bc"] = ":BufferLinePickClose<CR>",

		-- Packer compile
		["<Leader>pa"] = ":PackerClean<CR>",
		["<Leader>pc"] = ":PackerCompile<CR>",
		["<Leader>ps"] = ":PackerSync<CR>",
		["<Leader>pS"] = ":PackerStatus<CR>",
		["<Leader>pu"] = ":PackerUpdate<StatusCR>",
		["<Leader>pi"] = ":PackerInstall<CR>",
		["<Leader>pp"] = ":PackerProfile<CR>",

		-- Search
		["<Leader>sc"] = ":Telescope colorscheme<CR>",
		["<Leader>sp"] = ":Telescope projects<CR>",
		["<Leader>sh"] = ":Telescope help_tags<cr>",
		["<Leader>sl"] = ":Telescope resume<cr>",
		["<Leader>sM"] = ":Telescope man_pages<cr>",
		["<Leader>sr"] = ":Telescope oldfiles<cr>",
		["<Leader>sR"] = ":Telescope registers<cr>",
		["<Leader>sk"] = ":Telescope keymaps<cr>",
		["<Leader>sC"] = ":Telescope commands<cr>",

		-- Session
		["<Leader>Sf"] = ":SessionManager load_session<CR>",
		["<Leader>Sd"] = ":SessionManager delete_session<CR>",
		["<Leader>Ss"] = ":SessionManager save_current_session<CR>",
		["<Leader>Sl"] = ":SessionManager load_last_session<CR>",
		["<Leader>SL"] = ":SessionManager load_current_dir_session<CR>",
	},
	insert_mode = {

		-- Line navigation
		["<C-k>"] = "<Up>",
		["<C-l>"] = "<Right>",
		["<C-j>"] = "<Down>",
		["<C-h>"] = "<Left>",
		["<C-f>"] = "<esc>I",
		["<C-a>"] = "<esc>A",
		["<C-e>"] = "<esc>ea",
		["<C-b>"] = "<esc>bi",
		["<C-d>"] = "<BS>",
		["<C-s>"] = "<Del>",

		-- Move current line / block with Alt-j/k like vscode.
		["<A-j>"] = "<Esc>:m .+1<CR>==gi",
		["<A-k>"] = "<Esc>:m .-2<CR>==gi",

		["jk"] = "<Esc>",
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

		-- Replace all word on cursor in buffer
		["<Leader>r"] = { ":%s/\\<<C-R><C-W>\\>\\C//g<left><left>", { noremap = true } },

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
		-- navigate tab completion with <c-j> and <c-k>, runs conditionally
		-- ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
		-- ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
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

local mode_adapters = {
	normal_mode = "n",
	insert_mode = "i",
	term_mode = "t",
	visual_mode = "v",
	visual_block_mode = "x",
	command_mode = "c",
}

local map = vim.api.nvim_set_keymap

-- Set space as Leader key
map("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

for mode, mappings in pairs(keymaps) do
	mode = mode_adapters[mode]
	for k, v in pairs(mappings) do
		if type(v) == "table" then
			map(mode, k, v[1], v[2])
		else
			map(mode, k, v, { noremap = true, silent = true })
		end
	end
end

map("n", "<F6>", ":terminal lazygit<CR>", { noremap = true, silent = false })

-- Add Packer commands because we are not loading it at startup
vim.cmd("silent! command PackerClean lua require 'plugins' require('packer').clean()")
vim.cmd("silent! command PackerCompile lua require 'plugins' require('packer').compile()")
vim.cmd("silent! command PackerInstall lua require 'plugins' require('packer').install()")
vim.cmd("silent! command PackerStatus lua require 'plugins' require('packer').status()")
vim.cmd("silent! command PackerSync lua require 'plugins' require('packer').sync()")
vim.cmd("silent! command PackerUpdate lua require 'plugins' require('packer').update()")
vim.cmd("silent! command PackerProfile lua require 'plugins' require('packer').profile_output()")
