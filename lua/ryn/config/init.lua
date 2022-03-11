local utils = require "ryn.utils"

local M = {}

function M:load_core()
  local cores = {
    "options",
    -- "keymaps",
  }

  for _, core in ipairs(cores) do
    require("ryn.config." .. core).config()
  end

  local user_config = vim.fn.stdpath "config" .. "/config.lua"
  pcall(dofile, user_config or {})

  for _, core in ipairs(cores) do
    require("ryn.config." .. core).setup()
  end
end

function M:init()
  -- set global variable
  if vim.tbl_isempty(Ryn or {}) then
    Ryn = vim.deepcopy(require "ryn.config.defaults")
  end

  require("ryn.config.keymaps").load_defaults()
  require("ryn.config.keymaps").add_keymaps(require "ryn.user.keymaps")

  require "ryn.config.autocmds"

  -- set some options and apply user config if exist
  M:load_core()
end

function M:load()
  -- This function will get all lua file inside param director and call `config` func
  -- Make sure you know what you do if you want to add another file inside
  local configs = utils.list_files(vim.fn.stdpath "config" .. "/lua/ryn/plugins")
  for _, config in ipairs(configs) do
    require("ryn.plugins." .. config).config()
  end

  -- Merge into global variables for plugins purpose
  utils.merge_to_left(Ryn.builtins, Ryn.builtins.user or {})

  require("ryn.config.keymaps").load(Ryn.keys)

  if Ryn.format_on_save then
    utils.enable_format_on_save()
  end
end

return M
