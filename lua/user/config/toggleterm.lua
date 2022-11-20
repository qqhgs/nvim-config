local toggleterm_present, toggleterm = pcall(require, "toggleterm")
if not toggleterm_present then
  return
end

toggleterm.setup {
  open_mapping = [[<C-t>]],
  -- direction = "float",
  highlights = {
    Normal = { link = "Normal" },
    NormalFloat = { link = "NormalFloat" },
    FloatBorder = { link = "FloatBorder" },
    SignColumn = { link = "Normal" },
  },
  float_opts = {
    border = "curved",
    winblend = 5,
    width = math.min(vim.o.columns, math.max(80, vim.o.columns - 10)),
    height = math.min(vim.o.lines, math.max(20, vim.o.lines - 6)),
  },
}

-- set autocmd for escape keymap from terminal buffer
local escape_map = "<C-\\>"
function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, "t", escape_map, [[<C-\><C-n><C-W>l]], { noremap = true })
end
vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

-- Create custom terminal
local function custom_terminal(cmd)
  if not cmd then
    return
  end
  return require("toggleterm.terminal").Terminal:new {
    cmd = cmd,
    -- hidden = true,
    direction = "float",
  }
end

require("user.config.whichkey").registers {
  x = {
    name = "Tool",
    l = {
      function()
        custom_terminal("lazygit"):toggle()
      end,
      "Lazygit",
    },
    w = {
      function()
        custom_terminal("wuzz"):toggle()
      end,
      "Wuzz",
    },
  },
}
