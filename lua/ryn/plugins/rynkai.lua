-- local utils = require("utils")
local M = {}

M.config = function()
  local config_file = Ryn.builtins.user.config_file or vim.fn.stdpath "config" .. "/lua/ryn/plugins/rynkai.lua"
  local rynkai_dir = vim.fn.stdpath "data" .. "/site/pack/jetpack/src/rynkai.nvim/lua/rynkai/colors/"

  Ryn.builtins.rynkai = {
    theme = "onedark", -- this field is a must.
    config_file = config_file,
    rynkai_dir = rynkai_dir,
  }
end

M.setup = function()
  require("rynkai").setup(Ryn.builtins.rynkai)

  vim.cmd [[ colorscheme rynkai ]]

  require("telescope").load_extension "rynkai"

  vim.api.nvim_set_keymap("n", "<Leader>sc", ":Telescope rynkai<CR>", { noremap = true, silent = true })
end

return M
