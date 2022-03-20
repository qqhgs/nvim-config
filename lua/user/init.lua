-- local settings = require("user.utils").list_files(vim.fn.stdpath "config" .. "/lua/user/settings")
-- for _, name in ipairs(settings) do
--   require("user." .. name)
-- end

-- require "user.plugins"
local cores = {
	"autocmds",
	"options",
	"keymaps",
	"plugins"
}
for _, core in ipairs(cores) do
  require("user." .. core)
end
