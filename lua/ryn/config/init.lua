local utils = require "ryn.utils"

local M = {}

function M:init()
  -- set global variable
  if vim.tbl_isempty(Ryn or {}) then
    Ryn = vim.deepcopy(require "ryn.config.defaults")
  end

  require "ryn.config.autocmds"

  -- assign basic options and keymaps
  for _, v in
    ipairs {
      "options",
      "keymaps",
    }
  do
    require("ryn.config." .. v).config()
  end

  -- assign defaults config for each builtin plugins
  local configs = {
    "comment",
    "cmp",
    "rynkai",
    "nvimtree",
    "autopairs",
    "bufferline",
    "gitsigns",
    "indentline",
    "lsp",
    "statusline",
    "null_ls",
    "telescope",
    "project",
    "luasnip",
    "toggleterm",
    "whichkey",
    "treesitter",
  }
  for _, config in ipairs(configs) do
    require("ryn.plugins." .. config).config()
  end

  -- load user configs if safely
  pcall(require, "ryn.user.config")

  -- merge user configs into Ryn global variable
  local user_config_present, user_config = pcall(require, "ryn.user")
  if user_config_present then
    utils.merge_to_left(Ryn, user_config)
  end

  if Ryn.format_on_save then
    utils.enable_format_on_save()
  end

  pcall(require, "ryn.config.setup")
end

return M
