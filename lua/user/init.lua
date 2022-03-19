local utils = require "user.utils"

local settings = utils.list_files(vim.fn.stdpath "config" .. "/lua/user/settings")
for _, name in ipairs(settings) do
  require("user.settings." .. name)
end

require "user.plugins"

-- local modules = utils.list_files(vim.fn.stdpath "config" .. "/lua/user/modules")
-- for _, module in ipairs(modules) do
--   require("user.modules." .. module)
-- end

require("persistence").setup()
