local M = {}

M.config = function()
  Ryn.builtins.toggleterm = {
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
end

M.setup = function()
  require("toggleterm").setup(Ryn.builtins.toggleterm.setup)

  local escape_map = Ryn.builtins.toggleterm.escape_map
  function _G.set_terminal_keymaps()
    vim.api.nvim_buf_set_keymap(0, "t", escape_map, [[<C-\><C-n><C-W>l]], { noremap = true })
  end

  vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

  if Ryn.builtins.toggleterm.callback then
    Ryn.builtins.toggleterm.callback()
  end
end

return M
