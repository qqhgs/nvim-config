local util = require"user.util"

local present, toggleterm = pcall(require, "toggleterm")
if not present then
  return
end
local configs = {
  escape_map = "<C-\\>",
  setup = {
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
  },
}

toggleterm.setup(configs.setup)

local escape_map = configs.escape_map
function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, "t", escape_map, [[<C-\><C-n><C-W>l]], { noremap = true })
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

local Terminal = require("toggleterm.terminal").Terminal

local function setup(cmd)
  if not cmd then
    return
  end

  local config = {
    cmd = cmd,
		hidden = true,
    dir = "git_dir",
    direction = "window",
    float_opts = {
      border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd "startinsert!"
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- -- function to run on closing the terminal
    -- on_close = function(term)
    --   vim.cmd "Closing terminal"
    -- end,
  }

	return Terminal:new(config)
end

function __LAZYGIT_TOGGLE()
  setup("lazygit"):toggle()
end

function __WUZZ_TOGGLE()
  setup("wuzz"):toggle()
end

util.keymap("n", "<F6>", ":lua __LAZYGIT_TOGGLE()<CR>")
util.keymap("n", "<F7>", ":lua __WUZZ_TOGGLE()<CR>")
